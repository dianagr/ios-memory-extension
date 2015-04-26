//
//  SCRequestTest.m
//  Challenge
//
//  Created by D Gren on 4/25/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import "SCAPI.h"
#import "SCRequest.h"
#import "SCRequestTest.h"

#import <OHHTTPStubs/OHHTTPStubs.h>

@implementation SCRequestTest

- (void)tearDown {
  [OHHTTPStubs removeAllStubs];
  [super tearDown];
}

- (void)testSuccess {
  NSData *fakeJSON = [@"{\"key\" : \"value\"}" dataUsingEncoding:NSUTF8StringEncoding];
  [self stubWithResponse:[OHHTTPStubsResponse responseWithData:fakeJSON statusCode:200 headers:nil]];
  XCTestExpectation *expectation = [self expectationWithDescription:@"Success request"];
  SCRequest *request = [SCRequest newRequestGETWithPath:nil params:nil completion:^(id response, NSError *error) {
    XCTAssertNil(error);
    XCTAssertEqualObjects(response, @{@"key": @"value"});
    [expectation fulfill];
  }];
  [self verifyRequest:request];
}

- (void)testRequestError {
  [self stubWithResponse:[OHHTTPStubsResponse responseWithError:[NSError errorWithDomain:@"Request error" code:400 userInfo:nil]]];
  XCTestExpectation *expectation = [self expectationWithDescription:@"Request error"];
  SCRequest *request = [SCRequest newRequestGETWithPath:nil params:nil completion:^(id response, NSError *error) {
    XCTAssertNotNil(error);
    XCTAssertEqual(error.code, 400);
    [expectation fulfill];
  }];
  [self verifyRequest:request];
}

- (void)testJSONError {
  NSData *badJSON = [@"This some bad formatted JSON" dataUsingEncoding:NSUTF8StringEncoding];
  [self stubWithResponse:[OHHTTPStubsResponse responseWithData:badJSON statusCode:200 headers:nil]];
  XCTestExpectation *expectation = [self expectationWithDescription:@"JSON error" ];
  SCRequest *request = [SCRequest newRequestGETWithPath:nil params:nil completion:^(id response, NSError *error) {
    XCTAssertNotNil(error);
    [expectation fulfill];
  }];
  [self verifyRequest:request];
}

#pragma mark Helpers

- (void)verifyRequest:(SCRequest *)request {
  [request resume];
  [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
    [request cancel];
  }];
}

- (void)stubWithResponse:(OHHTTPStubsResponse *)response {
  [OHHTTPStubs stubRequestsPassingTest:^BOOL (NSURLRequest *request) {
    return [request.URL.host isEqualToString:[SCAPI host]];
  } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
    return response;
  }];
}

@end
