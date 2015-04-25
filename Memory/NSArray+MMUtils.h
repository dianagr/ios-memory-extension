//
//  NSArray+MMGameSet.h
//  Challenge
//
//  Created by D Gren on 4/21/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (MMUtils)

/*! Create a new array with the items shuffled.
 @param .
 */
+ (NSArray *)shuffledFromArray:(NSArray *)array;

/*! Check whether all items in the given array are the same based on the specified matching block.
 @param items The array of items to check if matching.
 @param matching The block to use for checking equality between items.
 */
+ (BOOL)isEqualAllItems:(NSArray *)items;

/*! Create a subarray from given array with the specified max range.
 @discussion Behaves as subarrayWithRange except if the range extends outside the array count, it will return the biggest possible array. NSRangeException is thrown if range.location is outside the array bounds.
 */
+ (NSArray *)subarrayFromArray:(NSArray *)array maxRange:(NSRange)range;

@end
