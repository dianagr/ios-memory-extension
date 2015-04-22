//
//  MMCollectionViewController.m
//  Challenge
//
//  Created by Diana Gren on 4/11/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import "MMCollectionViewController.h"

#import "MMCollectionViewCell.h"
#import "NSArray+MMGameSet.h"

#import <ChallengeKit/ChallengeKit.h>

NSString *const MMCollectionViewDidOpenPairNotification = @"MMCollectionViewDidOpenPairNotification";
NSString *const MMCollectionViewOpenedIndexesKey = @"MMCollectionViewOpenedIndexesKey";

static const CGFloat kMMUIiewAnimationDuration = 0.2;

typedef void(^FlipAnimationBlock)();
typedef void(^FlipAnimationCompletionBlock)(BOOL finished);

@interface MMCollectionViewController ()
@property (strong, nonatomic) NSMutableArray *flippedIndexPaths;
@property (copy, nonatomic) NSArray *tracks;
@end

@implementation MMCollectionViewController

#pragma mark Private

- (NSMutableArray *)flippedIndexPaths {
  if (!_flippedIndexPaths) {
    _flippedIndexPaths = [NSMutableArray array];
  }
  return _flippedIndexPaths;
}

- (NSArray *)_flippedTracksForIndexPaths:(NSArray *)indexPaths {
  NSMutableArray *flippedTracks = [NSMutableArray array];
  for (NSIndexPath *indexPath in indexPaths) {
    [flippedTracks addObject:self.tracks[indexPath.item]];
  }
  return [flippedTracks copy];
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

- (void)_resetCellsForIndexPaths:(NSArray *)indexPaths collectionView:(UICollectionView *)collectionView {
  BOOL allOpenedItemsEqual = [NSArray isEqualAllItems:[self _flippedTracksForIndexPaths:indexPaths] equalBlock:^BOOL(NSDictionary *track1, NSDictionary *track2) {
    return [track1[[CKSoundCloud artworkURLKey]] isEqual:track2[[CKSoundCloud artworkURLKey]]];
  }];

  if (!allOpenedItemsEqual) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      for (NSIndexPath *indexPath in indexPaths) {
        MMCollectionViewCell *cell = (MMCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [UIView transitionWithView:cell.contentView duration:kMMUIiewAnimationDuration options:0 animations:^{
          cell.flippedUp = NO;
        } completion:nil];
      }
    });
  }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  if (self.flippedIndexPaths.count >= 2) {
    NSArray *indexPaths = [self.flippedIndexPaths copy];
    [self.flippedIndexPaths removeAllObjects];
    [self _resetCellsForIndexPaths:indexPaths collectionView:collectionView];
  }

  MMCollectionViewCell *cell = (MMCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
  if (!cell.isFlippedUp) {
    [UIView transitionWithView:cell.contentView duration:kMMUIiewAnimationDuration options:0 animations:^{
      cell.flippedUp = YES;
      [self.flippedIndexPaths addObject:indexPath];
    } completion:nil];
  }
}

@end
