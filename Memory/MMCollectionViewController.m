//
//  MMCollectionViewController.m
//  Challenge
//
//  Created by Diana Gren on 4/11/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import "MMCollectionViewController.h"

#import "MMCollectionViewCell.h"

@implementation MMCollectionViewController

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MMCollectionViewCell *cell = (MMCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MMCollectionViewCell class]) forIndexPath:indexPath];
  return cell;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  MMCollectionViewCell *cell = (MMCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
  [UIView transitionWithView:cell.contentView duration:0.2 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
    cell.flippedUp = !cell.isFlippedUp;
  } completion:nil];
}

@end
