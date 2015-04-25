//
//  NSArray+MMGameSet.h
//  Challenge
//
//  Created by D Gren on 4/21/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL(^NSArrayIsEqualBlock)(id obj1, id obj2);

@interface NSArray (MMGameSet)

/*! Create a new memory game from the given items, will duplicate each of the items in the array.
 @param The items for the game.
 */
+ (NSArray *)shuffledFromArray:(NSArray *)items maxCount:(NSInteger)maxCount;

/*! Check whether all items in the given array are the same based on the specified matching block.
 @param items The array of items to check if matching.
 @param matching The block to use for checking equality between items.
 */
+ (BOOL)isEqualAllItems:(NSArray *)items;

@end
