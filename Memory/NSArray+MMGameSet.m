//
//  NSArray+MMGameSet.m
//  Challenge
//
//  Created by Diana Gren on 4/21/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
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

+ (BOOL)isEqualAllItems:(NSArray *)items equalBlock:(NSArrayIsEqualBlock)isEqual {
  for (id object in items) {
    if (!isEqual(object, items.firstObject)) {
      return NO;
    }
  }
  return YES;
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
