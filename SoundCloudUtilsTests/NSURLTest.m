//
//  NSURLTest.m
//  Challenge
//
//  Created by Diana Gren on 4/25/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSURL+SCUtils.h"

@interface NSURLTest : XCTestCase

@end

@implementation NSURLTest

- (void)testBuildURL {
  XCTAssertEqualObjects([NSURL URLWithHost:@"host" path:nil queryParams:nil], [NSURL URLWithString:@"host"]);
  NSDictionary *params = nil;
  XCTAssertEqualObjects([NSURL URLWithHost:@"host" path:@"path" queryParams:params], [NSURL URLWithString:@"host/path"]);
  params = @{@"param1": @"value1"};
  XCTAssertEqualObjects([NSURL URLWithHost:@"host" path:@"path" queryParams:params], [NSURL URLWithString:@"host/path?param1=value1"]);
  params = @{@"param1": @"value1", @"param2": @"value2"};
  XCTAssertEqualObjects([NSURL URLWithHost:@"host" path:@"path" queryParams:params], [NSURL URLWithString:@"host/path?param1=value1&param2=value2"]);
}

@end
