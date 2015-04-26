//
//  MMCollectionView.m
//  Challenge
//
//  Created by D Gren on 4/25/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import "MMCollectionView.h"

#import "MMCollectionViewCell.h"

static const CGFloat kMMUIiewAnimationDuration = 0.2;
static const CGFloat kMMCellFinishedAlpha = 0.7;

@implementation MMCollectionView

- (void)openCellsAtIndexPaths:(NSArray *)indexPaths animated:(BOOL)animated completion:(FlippedIndexPathCompletion)completion {
  [self _flipCells:YES atIndexPaths:indexPaths animated:animated completion:completion];
}

- (void)closeCellsAtIndexPaths:(NSArray *)indexPaths animated:(BOOL)animated completion:(FlippedIndexPathCompletion)completion {
  [self _flipCells:NO atIndexPaths:indexPaths animated:animated completion:completion];
}

- (void)fadeCellsAtIndexPaths:(NSArray *)indexPaths animated:(BOOL)animated {
  for (NSIndexPath *indexPath in indexPaths) {
    MMCollectionViewCell *cell = (MMCollectionViewCell *)[self cellForItemAtIndexPath:indexPath];
    if (animated) {
      [UIView animateWithDuration:kMMUIiewAnimationDuration animations:^{
        cell.alpha = kMMCellFinishedAlpha;
      }];
    } else {
      cell.alpha = kMMCellFinishedAlpha;
    }
  }
}

#pragma mark Private

- (void)_flipCells:(BOOL)opened atIndexPaths:(NSArray *)indexPaths animated:(BOOL)animated completion:(FlippedIndexPathCompletion)completion {
  for (NSIndexPath *indexPath in indexPaths) {
    MMCollectionViewCell *cell = (MMCollectionViewCell *)[self cellForItemAtIndexPath:indexPath];
    if (cell.flippedUp != opened) {
      [self _flipCell:cell opened:opened animated:animated completion:^(BOOL finished) {
        if (completion) {
          completion(indexPath);
        }
      }];
    }
  }
}

- (void)_flipCell:(MMCollectionViewCell *)cell opened:(BOOL)opened animated:(BOOL)animated completion:(void (^)(BOOL finished))completion {
  if (animated) {
    [UIView transitionWithView:cell.contentView duration:kMMUIiewAnimationDuration options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
      cell.flippedUp = opened;
    } completion:completion];
  } else {
    cell.flippedUp = opened;
    if (completion) {
      completion(YES);
    }
  }

}

@end
