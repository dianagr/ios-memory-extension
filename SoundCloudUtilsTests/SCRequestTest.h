//
//  Header.h
//  Challenge
//
//  Created by Diana Gren on 4/25/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import <XCTest/XCTest.h>

@class OHHTTPStubsResponse;
@class SCRequest;
@interface SCRequestTest : XCTestCase

- (void)verifyRequest:(SCRequest *)request;

- (void)stubWithResponse:(OHHTTPStubsResponse *)response;

@end