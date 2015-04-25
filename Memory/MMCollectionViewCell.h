//
//  MMCollectionViewCell.h
//  Challenge
//
//  Created by D Gren on 4/11/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface MMCollectionViewCell : UICollectionViewCell

@property (assign, nonatomic, getter=isFlippedUp) IBInspectable BOOL flippedUp;
@property (strong, nonatomic) NSDictionary *track;

@end
