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
static const CGFloat kMMUIiewAnimationDurationFast = 0.1;
static const CGFloat kMMCellFinishedAlpha = 0.7;

static const CGFloat kCheckMarkSmall = 75;
static const CGFloat kCheckMarkExpanded = 200;
static const CGFloat kCheckMarkNormal = 150;

@interface MMCollectionView ()
@property (strong, nonatomic) UIImageView *finishedImageView;
@property (strong, nonatomic) NSLayoutConstraint *imageWidthConstraint;
@property (strong, nonatomic) NSMutableSet *fadedIndexPaths;
@end

@implementation MMCollectionView

- (void)awakeFromNib {
  [super awakeFromNib];
  self.finishedImageView.hidden = YES;
  self.finishedImageView.image = [UIImage imageNamed:@"check"];
}

#pragma mark Properties

- (UIImageView *)finishedImageView {
  if (!_finishedImageView) {
    _finishedImageView = [UIImageView new];
    _finishedImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_finishedImageView];
    
    _finishedImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_finishedImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_finishedImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_finishedImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_finishedImageView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    _imageWidthConstraint = [NSLayoutConstraint constraintWithItem:_finishedImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:kCheckMarkSmall];
    [self addConstraint:_imageWidthConstraint];
  }
  return _finishedImageView;
}

- (NSMutableSet *)fadedIndexPaths {
  if (!_fadedIndexPaths) {
    _fadedIndexPaths = [NSMutableSet set];
  }
  return _fadedIndexPaths;
}

#pragma mark Public

- (void)openCellsAtIndexPaths:(NSSet *)indexPaths animated:(BOOL)animated completion:(FlippedIndexPathCompletion)completion {
  [self _flipCells:YES atIndexPaths:indexPaths animated:animated completion:completion];
}

- (void)closeCellsAtIndexPaths:(NSSet *)indexPaths animated:(BOOL)animated completion:(FlippedIndexPathCompletion)completion {
  [self _flipCells:NO atIndexPaths:indexPaths animated:animated completion:completion];
}

- (void)fadeCellsAtIndexPaths:(NSSet *)indexPaths animated:(BOOL)animated {
  for (NSIndexPath *indexPath in indexPaths) {
    MMCollectionViewCell *cell = (MMCollectionViewCell *)[self cellForItemAtIndexPath:indexPath];
    if (animated) {
      [UIView animateWithDuration:kMMUIiewAnimationDuration animations:^{
        cell.alpha = kMMCellFinishedAlpha;
      }];
    } else {
      cell.alpha = kMMCellFinishedAlpha;
    }
    [self.fadedIndexPaths addObject:indexPath];
  }
  if (self.fadedIndexPaths.count >= [self numberOfItemsInSection:0]) {
    [self _finishGameAnimated:animated];
  }
}

#pragma mark Private

//! Display a check mark when game is finished
- (void)_finishGameAnimated:(BOOL)animated {
  [UIView animateWithDuration:kMMUIiewAnimationDurationFast animations:^{
    self.finishedImageView.hidden = NO;
    self.imageWidthConstraint.constant = kCheckMarkExpanded;
    [self.finishedImageView layoutIfNeeded];
  } completion:^(BOOL finished) {
    [UIView animateWithDuration:kMMUIiewAnimationDuration animations:^{
      self.imageWidthConstraint.constant = kCheckMarkNormal;
      [self.finishedImageView layoutIfNeeded];
    }];
  }];
}

- (void)_flipCells:(BOOL)opened atIndexPaths:(NSSet *)indexPaths animated:(BOOL)animated completion:(FlippedIndexPathCompletion)completion {
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
