//
//  MMCollectionViewController.m
//  Challenge
//
//  Created by D Gren on 4/11/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import "MMCollectionViewController.h"

#import "MMCollectionViewCell.h"
#import "MMCollectionView.h"

#import <SoundCloudUtils/SoundCloudUtils.h>

static const NSUInteger kIdenticalItemsCount = 2;
static const NSUInteger kMaxDifferentItemsCount = 4;
static const NSTimeInterval kAnimationDelay = 0.5;

@interface MMCollectionViewController ()
@property (strong, nonatomic) NSMutableArray *flippedIndexPaths;
@property (copy, nonatomic) NSArray *tracks;
@end

@implementation MMCollectionViewController

#pragma mark Properties

- (void)setTracks:(NSArray *)tracks {
  NSArray *strippedTracks = [NSArray subarrayFromArray:tracks maxRange:NSMakeRange(0, kMaxDifferentItemsCount)];
  for (NSUInteger count = 1; count < kIdenticalItemsCount; count++) {
    strippedTracks = [strippedTracks arrayByAddingObjectsFromArray:strippedTracks];
  }
  _tracks = [NSArray shuffledFromArray:strippedTracks];
}

- (NSMutableArray *)flippedIndexPaths {
  if (!_flippedIndexPaths) {
    _flippedIndexPaths = [NSMutableArray array];
  }
  return _flippedIndexPaths;
}

#pragma mark Private

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

- (void)collectionView:(MMCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [collectionView openCellsAtIndexPaths:@[indexPath] animated:YES completion:^(NSIndexPath *flippedIndexPath) {
    [self.flippedIndexPaths addObject:flippedIndexPath];
    if (self.flippedIndexPaths.count == kIdenticalItemsCount) {
      if (![NSArray isEqualAllItems:[self _flippedTracksForIndexPaths:self.flippedIndexPaths]]) {
        NSArray *flippedIndexPaths = [self.flippedIndexPaths copy];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kAnimationDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          [collectionView closeCellsAtIndexPaths:flippedIndexPaths animated:YES completion:nil];
        });
      }
      [self.flippedIndexPaths removeAllObjects];
    }
  }];

}

@end
