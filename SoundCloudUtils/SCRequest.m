//
//  SCRequest.m
//  Challenge
//
//  Created by Diana Gren on 4/25/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import "SCRequest.h"

#import "NSURL+SCUtils.h"
#import "SCAPI.h"

@interface SCRequest ()
@property (strong, nonatomic) NSURLSessionDataTask *task;
@end

@implementation SCRequest

+ (instancetype)newRequestGETWithPath:(NSString *)path params:(NSDictionary *)params completion:(SCRequestCompletion)completion {
  NSURL *url = [NSURL URLWithHost:[SCAPI host] path:path queryParams:[self _appendAuthenticationParamsToQueryParams:params]];
  SCRequest *request = [SCRequest new];
  request.task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    NSJSONSerialization *jsonResponse = nil;
    if (error) {
      NSLog(@"Error loading data: %@", error.localizedDescription);
    } else {
      jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
      if (error) {
        NSLog(@"Error parsin json: %@", error.localizedDescription);
      }
    }
    if (completion) {
      completion(jsonResponse, error);
    }
  }];
  return request;
}

#pragma mark Private

+ (NSDictionary *)_appendAuthenticationParamsToQueryParams:(NSDictionary *)queryParams {
  NSMutableDictionary *params = queryParams ? [queryParams mutableCopy] : [NSMutableDictionary new];
  if ([SCAPI clientId]) {
    params[[SCAPI clientIdKey]] = [SCAPI clientId];
  }
  return params;
}

#pragma mark Public

- (void)resume {
  [self.task resume];
}

- (void)cancel {
  [self.task cancel];
}

@end
