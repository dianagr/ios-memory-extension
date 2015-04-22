//
//  NSURL+CKUtils.m
//  Challenge
//
//  Created by D Gren on 4/8/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import "NSURL+CKUtils.h"

@implementation NSURL (CKUtils)

+ (instancetype)URLWithHost:(NSString *)host path:(NSString *)path queryParams:(NSDictionary *)params {
  NSString *urlString = host;
  if (path) {
    urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"/%@", path]];
  }
  NSString *queryString = [self _queryStringFromParams:params];
  if (queryString) {
    urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"?%@", queryString]];
  }
  return [NSURL URLWithString:urlString];
}

#pragma mark Private

+ (NSString *)_queryStringFromParams:(NSDictionary *)params {
  NSMutableArray *keyValues = [NSMutableArray array];
  [params enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL *stop) {
    [keyValues addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
  }];
  return keyValues.count > 0 ? [keyValues componentsJoinedByString:@"&"] : nil;
}

@end
