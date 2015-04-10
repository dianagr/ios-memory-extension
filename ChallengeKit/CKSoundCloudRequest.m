//
//  CKSoundCloudRequest.m
//  Challenge
//
//  Created by Diana Gren on 4/8/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import "CKSoundCloudRequest.h"

#import "CKSoundCloud.h"
#import "NSURL+CKUtils.h"

@interface CKSoundCloudRequest ()
@property (strong, nonatomic) NSURLSessionDataTask *task;
@end

@implementation CKSoundCloudRequest

+ (instancetype)newRequestGETWithPath:(NSString *)path params:(NSDictionary *)params completion:(CKSoundCloudRequestCompletion)completion {
  NSURL *url = [NSURL URLWithHost:[CKSoundCloud host] path:path queryParams:[self _appendAuthenticationParamsToQueryParams:params]];
  CKSoundCloudRequest *request = [CKSoundCloudRequest new];
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
      dispatch_async(dispatch_get_main_queue(), ^{
        completion(jsonResponse, error);
      });
    }
  }];
  return request;
}

#pragma mark Private

+ (NSDictionary *)_appendAuthenticationParamsToQueryParams:(NSDictionary *)queryParams {
  NSMutableDictionary *params = [queryParams mutableCopy];
  if ([CKSoundCloud clientId]) {
    params[[CKSoundCloud clientIdKey]] = [CKSoundCloud clientId];
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
