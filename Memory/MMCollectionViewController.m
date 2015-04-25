//
//  MMCollectionViewController.m
//  Challenge
//
//  Created by D Gren on 4/11/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import "MMCollectionViewController.h"

#import "MMCollectionViewCell.h"
#import "NSArray+MMGameSet.h"
#import "MMCollectionView.h"

#import <SoundCloudUtils/SoundCloudUtils.h>

@interface MMCollectionViewController ()
@property (strong, nonatomic) NSMutableArray *flippedIndexPaths;
@property (copy, nonatomic) NSArray *tracks;
@end

@implementation MMCollectionViewController

#pragma mark Properties

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
  [collectionView openCellsAtIndexPaths:@[indexPath] animated:YES completion:^(BOOL finished) {
    [self.flippedIndexPaths addObject:indexPath];
    if (self.flippedIndexPaths.count == 2) {
      if (![NSArray isEqualAllItems:[self _flippedTracksForIndexPaths:self.flippedIndexPaths]]) {
        [collectionView closeCellsAtIndexPaths:[self.flippedIndexPaths copy] animated:YES completion:nil];
      }
      [self.flippedIndexPaths removeAllObjects];
    }
  }];

}

@end
