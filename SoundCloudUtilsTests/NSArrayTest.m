//
//  NSArrayTest.m
//  Challenge
//
//  Created by Diana Gren on 4/25/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSArray+SCUtils.h"

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
  
}

@end
