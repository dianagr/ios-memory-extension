//
//  MMCollectionView.h
//  Challenge
//
//  Created by Diana Gren on 4/25/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FlippedIndexPathCompletion)(BOOL finished);

@interface MMCollectionView : UICollectionView

- (void)openCellsAtIndexPaths:(NSArray *)indexPaths animated:(BOOL)animated completion:(FlippedIndexPathCompletion)completion;
- (void)closeCellsAtIndexPaths:(NSArray *)indexPaths animated:(BOOL)animated completion:(FlippedIndexPathCompletion)completion;

@end
