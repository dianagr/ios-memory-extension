//
//  MMCollectionViewController.h
//  Challenge
//
//  Created by D Gren on 4/11/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MMCollectionViewController;
@protocol MMCollectionViewControllerDelegate <NSObject>
- (void)collectionViewController:(MMCollectionViewController *)controller didSelectIndexPath:(NSIndexPath *)indexPath;
@end

@interface MMCollectionViewController : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) id<MMCollectionViewControllerDelegate> delegate;

/*! Set sound cloud tracks for this collection view.
 @param Array of NSDictionary objects representing a track on SoundCloud.
 */
- (void)setTracks:(NSArray /*of NSDictionary*/ *)tracks;

@end
