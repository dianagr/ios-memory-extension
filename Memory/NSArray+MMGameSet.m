//
//  NSArray+MMGameSet.m
//  Challenge
//
//  Created by D Gren on 4/21/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import "NSArray+MMGameSet.h"

@implementation NSArray (MMGameSet)

+ (NSArray *)shuffledFromArray:(NSArray *)items maxCount:(NSInteger)maxCount {
  if (items.count <= maxCount) {
    return [self _shuffledItems:items];
  } else {
    return [self _shuffledItems:[items subarrayWithRange:NSMakeRange(0, maxCount)]];
  }
}

+ (BOOL)isEqualAllItems:(NSArray *)items {
  NSSet *itemSet = [NSSet setWithArray:items];
  return itemSet.count == 1;
}

#pragma mark Private

+ (NSArray *)_shuffledItems:(NSArray *)items {
  NSMutableArray *mutableItems = [items mutableCopy];
  // Shuffle the objects in the array
  for (NSUInteger i = 0; i < items.count; ++i) {
    NSInteger nElements = items.count - i;
    NSInteger n = (arc4random() % nElements) + i;
    [mutableItems exchangeObjectAtIndex:i withObjectAtIndex:n];
  }
  return [mutableItems copy];
}

@end
