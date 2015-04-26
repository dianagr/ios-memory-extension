//
//  NSArrayTest.m
//  Challenge
//
//  Created by D Gren on 4/25/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSArray+SCUtils.h"

#import <Fox/Fox.h>

@interface NSArrayTest : XCTestCase

@end

@implementation NSArrayTest

- (void)testSubarray {
  NSArray *array = @[@0, @1, @3, @4, @5];

  NSArray *subArray = @[@3, @4];
  XCTAssertEqualObjects(subArray, [NSArray subarrayFromArray:array maxRange:NSMakeRange(2, 2)]);
  subArray = @[@3, @4, @5];
  XCTAssertEqualObjects(subArray, [NSArray subarrayFromArray:array maxRange:NSMakeRange(2, 10)]);
  XCTAssertNil([NSArray subarrayFromArray:array maxRange:NSMakeRange(10, 1)]);
}

- (void)testIsEqual {
  id<FOXGenerator> arraysOfIntegers = FOXArray(FOXInteger()); // Generate random variable-size arrays of randomly generated integers
  FOXAssert(FOXForAll(arraysOfIntegers, ^BOOL(NSArray *array) {
    NSNumber *previous = nil;
    for (NSNumber *number in array) {
      if (!previous || [number isEqualToNumber:previous]) {
        previous = number;
      } else {
        return ![NSArray isEqualAllItems:array];
      }
    }
    return [NSArray isEqualAllItems:array];
  }));
}

@end
