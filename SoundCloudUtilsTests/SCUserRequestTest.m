//
//  SCUserRequestTest.m
//  Challenge
//
//  Created by Diana Gren on 4/25/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import "SCRequestTest.h"

#import <OHHTTPStubs/OHHTTPStubs.h>

#import "SCAPI.h"
#import "SCUserRequest.h"

@interface SCUserRequestTest : SCRequestTest
@end

@implementation SCUserRequestTest

- (void)testSuccess {
  NSData *fakeJSON = [@"[{\"key\" : \"value\"}]" dataUsingEncoding:NSUTF8StringEncoding];
  [self stubWithResponse:[OHHTTPStubsResponse responseWithData:fakeJSON statusCode:200 headers:nil]];
  XCTestExpectation *expectation = [self expectationWithDescription:@"Success request"];
  SCUserRequest *request = [SCUserRequest newTracksListRequestForUserId:@1 completion:^(id response, NSError *error) {
    XCTAssertNil(error);
    XCTAssertEqualObjects(response, @[@{@"key": @"value"}]);
    [expectation fulfill];
  }];
  [self verifyRequest:request];
}

- (void)testJSONFormatError {
  NSData *fakeJSON = [@"{\"key\" : \"value\"}" dataUsingEncoding:NSUTF8StringEncoding];
  [self stubWithResponse:[OHHTTPStubsResponse responseWithData:fakeJSON statusCode:200 headers:nil]];
  XCTestExpectation *expectation = [self expectationWithDescription:@"JSON format error"];
  SCUserRequest *request = [SCUserRequest newTracksListRequestForUserId:@1 completion:^(id response, NSError *error) {
    XCTAssertNotNil(error);
    XCTAssertNil(response);
    [expectation fulfill];
  }];
  [self verifyRequest:request];
}

@end
