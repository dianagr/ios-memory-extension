//
//  CKSoundCloudRequest.m
//  Challenge
//
//  Created by Diana Gren on 4/8/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import "CKSoundCloudRequest.h"

#import "CKSoundCloud.h"

@interface CKSoundCloudRequest ()
@property (strong, nonatomic) NSURLSessionDataTask *task;
@end

@implementation CKSoundCloudRequest

+ (instancetype)newRequestGETWithPath:(NSString *)path params:(NSDictionary *)params completion:(CKSoundCloudRequestCompletion)completion {
  NSDictionary *appendedAuthParams = [self _appendAuthenticationParamsToQueryParams:params];
  NSString *queryString = [self _queryStringAppendingAuthenticationFromParams:appendedAuthParams];
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?%@", [self _host], path, queryString]];

  CKSoundCloudRequest *request = [CKSoundCloudRequest new];
  request.task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error) {
      NSLog(@"Error loading data: %@", error.localizedDescription);
    } else {
      [self _handleData:data completion:completion];
    }
  }];
  return request;
}

#pragma mark Private

+ (NSString *)_host {
  return @"https://api.soundcloud.com";
}

+ (void)_handleData:(NSData *)data completion:(CKSoundCloudRequestCompletion)completion {
  NSError *jsonError;
  NSJSONSerialization *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
  if (jsonError) {
    NSLog(@"Error parsing json: %@", jsonError.localizedDescription);
  } else if (completion) {
    dispatch_async(dispatch_get_main_queue(), ^{
      completion(jsonResponse);
    });
  }
}

+ (NSString *)_queryStringAppendingAuthenticationFromParams:(NSDictionary *)params {
  NSMutableArray *keyValues = [NSMutableArray array];
  [params enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL *stop) {
    [keyValues addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
  }];
  return [keyValues componentsJoinedByString:@"&"];
}

+ (NSDictionary *)_appendAuthenticationParamsToQueryParams:(NSDictionary *)queryParams {
  NSMutableDictionary *params = [queryParams mutableCopy];
  if ([CKSoundCloud clientId]) {
    params[@"client_id"] = [CKSoundCloud clientId];
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
