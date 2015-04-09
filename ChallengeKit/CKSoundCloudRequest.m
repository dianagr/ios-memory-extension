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
    if (error) {
      NSLog(@"Error loading data: %@", error.localizedDescription);
    } else {
      [self _handleData:data completion:completion];
    }
  }];
  return request;
}

#pragma mark Private

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
