//
//  MMCollectionViewController.m
//  Challenge
//
//  Created by Diana Gren on 4/11/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import "MMCollectionViewController.h"

#import "MMCollectionViewCell.h"

NSString *const MMCollectionViewDidOpenPairNotification = @"MMCollectionViewDidOpenPairNotification";
NSString *const MMCollectionViewOpenedIndexesKey = @"MMCollectionViewOpenedIndexesKey";

typedef void(^FlipAnimationBlock)();

@interface MMCollectionViewController ()
@property (strong, nonatomic) NSMutableArray *openedCardIndexPaths;
@property (copy, nonatomic) NSArray *tracks;
@end

@implementation MMCollectionViewController

#pragma mark Private

- (NSMutableArray *)openedCardIndexPaths {
  if (!_openedCardIndexPaths) {
    _openedCardIndexPaths = [NSMutableArray array];
  }
  return _openedCardIndexPaths;
}

- (void)_flipBackCells:(UICollectionView *)collectionView openIndexPaths:(NSArray *)openIndexPaths delay:(NSTimeInterval)delay {
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    for (NSIndexPath *indexPath in openIndexPaths) {
      MMCollectionViewCell *cell = (MMCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
      [self _flipCell:cell animationBlock:^{
        cell.flippedUp = NO;
      }];
    }
  });
}

- (void)_flipUpCellAtIndexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView {
  MMCollectionViewCell *cell = (MMCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
  if (!cell.isFlippedUp) {
    [self _flipCell:cell animationBlock:^{
      cell.flippedUp = YES;
      [self.openedCardIndexPaths addObject:indexPath];
      
      if (self.openedCardIndexPaths.count == 2) {
        NSArray *openedIndexPaths = [self.openedCardIndexPaths copy];
        [self.openedCardIndexPaths removeAllObjects];
        if (![self _openedCardsDidMatch:openedIndexPaths]) {
          [self _flipBackCells:collectionView openIndexPaths:openedIndexPaths delay:1];
        }
      }
    }];
  }
}

- (void)_flipCell:(UICollectionViewCell *)cell animationBlock:(FlipAnimationBlock)block {
  [UIView transitionWithView:cell.contentView duration:0.2 options:UIViewAnimationOptionTransitionFlipFromRight animations:block completion:nil];
}

- (BOOL)_openedCardsDidMatch:(NSArray *)indexPaths {
  NSMutableSet *openedCards = [NSMutableSet new];
  for (NSIndexPath *indexPath in indexPaths) {
    [openedCards addObject:self.tracks[indexPath.item]];
  }
  return openedCards.count == 1;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.tracks.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MMCollectionViewCell *cell = (MMCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MMCollectionViewCell class]) forIndexPath:indexPath];
  [cell setTrack:self.tracks[indexPath.item]];
  return cell;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [self _flipUpCellAtIndexPath:indexPath collectionView:collectionView];
}

@end
