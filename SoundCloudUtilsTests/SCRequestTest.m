//
//  SCRequestTest.m
//  Challenge
//
//  Created by D Gren on 4/25/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OHHTTPStubs/OHHTTPStubs.h>

#import "SCAPI.h"
#import "SCRequest.h"

@interface SCRequestTest : XCTestCase
@end

@implementation SCRequestTest

- (void)tearDown {
  [OHHTTPStubs removeAllStubs];
  [super tearDown];
}

- (void)testSuccess {
  NSData *fakeJSON = [@"{\"key\" : \"value\"}" dataUsingEncoding:NSUTF8StringEncoding];
  [self _stubWithResponse:[OHHTTPStubsResponse responseWithData:fakeJSON statusCode:200 headers:nil]];
  XCTestExpectation *expectation = [self expectationWithDescription:@"Success request"];
  SCRequest *request = [SCRequest newRequestGETWithPath:nil params:nil completion:^(NSDictionary *response, NSError *error) {
    XCTAssertNil(error);
    XCTAssertEqualObjects(response, @{@"key": @"value"});
    [expectation fulfill];
  }];
  [request resume];
  [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
    [request cancel];
  }];
}

- (void)testRequestError {
  [self _stubWithResponse:[OHHTTPStubsResponse responseWithError:[NSError errorWithDomain:@"Request error" code:400 userInfo:nil]]];
  XCTestExpectation *expectation = [self expectationWithDescription:@"Request error"];
  SCRequest *request = [SCRequest newRequestGETWithPath:nil params:nil completion:^(NSDictionary *response, NSError *error) {
    XCTAssertNotNil(error);
    XCTAssertEqual(error.code, 400);
    [expectation fulfill];
  }];
  [request resume];
  [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
    [request cancel];
  }];
}

- (void)testJSONError {
  NSData *badJSON = [@"This some bad formatted JSON" dataUsingEncoding:NSUTF8StringEncoding];
  [self _stubWithResponse:[OHHTTPStubsResponse responseWithData:badJSON statusCode:200 headers:nil]];
  XCTestExpectation *expectation = [self expectationWithDescription:@"JSON error"];
  SCRequest *request = [SCRequest newRequestGETWithPath:nil params:nil completion:^(NSDictionary *response, NSError *error) {
    XCTAssertNotNil(error);
    [expectation fulfill];
  }];
  [request resume];
  [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
    [request cancel];
  }];
}

#pragma mark Helpers

- (void)_stubWithResponse:(OHHTTPStubsResponse *)response {
  [OHHTTPStubs stubRequestsPassingTest:^BOOL (NSURLRequest *request) {
    return [request.URL.host isEqualToString:[SCAPI host]];
  } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
    return response;
  }];
}

@end
