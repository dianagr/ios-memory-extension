//
//  MMGameSet.m
//  Challenge
//
//  Created by Diana Gren on 4/17/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import "MMGameSet.h"

#import <stdlib.h>

static const NSInteger kMMGameSetCount = 4;

@implementation MMGameSet

+ (NSArray *)gameSetFromItems:(NSArray *)items {
  if (items.count <= kMMGameSetCount) {
    return [self _shuffledItems:items];
  } else {
    return [self _shuffledItems:[items subarrayWithRange:NSMakeRange(0, kMMGameSetCount)]];
  }
}

+ (NSArray *)_shuffledItems:(NSArray *)items {
  // Double all objects in the array
  NSMutableArray *mutableItems = [[items arrayByAddingObjectsFromArray:items] mutableCopy];
  
  // Shuffle the objects in the array
  for (NSUInteger i = 0; i < items.count; ++i) {
    NSInteger nElements = items.count - i;
    NSInteger n = (arc4random() % nElements) + i;
    [mutableItems exchangeObjectAtIndex:i withObjectAtIndex:n];
  }
  return [mutableItems copy];
}

@end
