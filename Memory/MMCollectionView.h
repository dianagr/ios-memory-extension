//
//  MMCollectionView.h
//  Challenge
//
//  Created by D Gren on 4/25/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FlippedIndexPathCompletion)(NSIndexPath *indexPath);

@interface MMCollectionView : UICollectionView

/*! Open cells at specified index paths.
 @param indexPaths Array of NSIndexPath objects that should be opened.
 @param animated Whether opening the cells should animate.
 @param completion Called upon completion.
 */
- (void)openCellsAtIndexPaths:(NSArray *)indexPaths animated:(BOOL)animated completion:(FlippedIndexPathCompletion)completion;

/*! Close cells at specified index paths.
 @param indexPaths Array of NSIndexPath objects that should close.
 @param animated Whether closing the cells should animate.
 @param completion Called upon completion.
 */
- (void)closeCellsAtIndexPaths:(NSArray *)indexPaths animated:(BOOL)animated completion:(FlippedIndexPathCompletion)completion;

/*! Fade cells at specified index paths.
 @param indexPaths Array of NSIndexPath objects that should fade.
 @param animated Whether fading the cells should animate.
 @param completion Called upon completion.
 */
- (void)fadeCellsAtIndexPaths:(NSArray *)indexPaths animated:(BOOL)animated;

@end
