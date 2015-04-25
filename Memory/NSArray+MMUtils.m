//
//  NSArray+MMGameSet.m
//  Challenge
//
//  Created by D Gren on 4/21/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import "NSArray+MMUtils.h"

@implementation NSArray (MMUtils)

+ (NSArray *)shuffledFromArray:(NSArray *)array {
  NSMutableArray *mutableItems = [array mutableCopy];
  // Shuffle the objects in the array
  for (NSUInteger i = 0; i < array.count; ++i) {
    NSInteger nElements = array.count - i;
    NSInteger n = (arc4random() % nElements) + i;
    [mutableItems exchangeObjectAtIndex:i withObjectAtIndex:n];
  }
  return [mutableItems copy];
}

+ (BOOL)isEqualAllItems:(NSArray *)items {
  NSSet *itemSet = [NSSet setWithArray:items];
  return itemSet.count == 1;
}

+ (NSArray *)subarrayFromArray:(NSArray *)array maxRange:(NSRange)range {
  if (array.count > range.location + range.length) {
    return [array subarrayWithRange:range];
  } else {
    return [array subarrayWithRange:NSMakeRange(range.location, array.count - range.location)];
  }
}

@end
