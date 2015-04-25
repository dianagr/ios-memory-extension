//
//  NSURLTest.m
//  Challenge
//
//  Created by D Gren on 4/25/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSURL+SCUtils.h"

@interface NSURLTest : XCTestCase

@end

@implementation NSURLTest

- (void)testBuildURL {
  NSDictionary *params = nil;
  XCTAssertEqualObjects([NSURL URLWithScheme:@"scheme" host:@"host" path:nil queryParams:params], [NSURL URLWithString:@"scheme://host"]);
  XCTAssertEqualObjects([NSURL URLWithScheme:@"scheme" host:@"host" path:@"path" queryParams:params], [NSURL URLWithString:@"scheme://host/path"]);
  params = @{@"param1": @"value1"};
  XCTAssertEqualObjects([NSURL URLWithScheme:@"scheme" host:@"host" path:@"path" queryParams:params], [NSURL URLWithString:@"scheme://host/path?param1=value1"]);
  params = @{@"param1": @"value1", @"param2": @"value2"};
  NSURL *url = [NSURL URLWithScheme:@"scheme" host:@"host" path:@"path" queryParams:params];
  XCTAssert([url isEqual:[NSURL URLWithString:@"scheme://host/path?param1=value1&param2=value2"]] || [url isEqual:[NSURL URLWithString:@"scheme://host/path?param2=value2&param1=value1"]]);
}

@end
