//
//  MMCollectionViewController.h
//  Challenge
//
//  Created by Diana Gren on 4/11/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *const MMCollectionViewDidOpenPairNotification;
extern NSString *const MMCollectionViewOpenedIndexesKey;

@interface MMCollectionViewController : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>

- (void)setTracks:(NSArray *)tracks;

@end
