//
//  NSURL+SCUtils.m
//  Challenge
//
//  Created by D Gren on 4/25/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import "NSURL+SCUtils.h"

@implementation NSURL (SCUtils)

+ (instancetype)URLWithScheme:(NSString *)scheme host:(NSString *)host path:(NSString *)path queryParams:(NSDictionary *)params {
  NSString *urlString = [NSString stringWithFormat:@"%@://%@", scheme, host];
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
