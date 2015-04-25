//
//  SCAPI.m
//  Challenge
//
//  Created by Diana Gren on 4/25/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import "SCAPI.h"

NSString *const kSCAPIFieldClientId = @"client_id";

NSString *const kSCAPIFieldUserId = @"user_id";
NSString *const kSCAPIFieldArtworkURL = @"artwork_url";

@implementation SCAPI

+ (NSString *)scheme {
  return @"https";
}

+ (NSString *)host {
  return @"api.soundcloud.com";
}

#pragma mark Client Id

+ (NSDictionary *)_apiAuthenticationCredentials {
  static NSDictionary *authCredentials = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"api_key" ofType:@"plist"];
    authCredentials = [NSDictionary dictionaryWithContentsOfFile:path];
  });
  return authCredentials;
}

+ (NSString *)clientId {
  return [self _apiAuthenticationCredentials][kSCAPIFieldClientId];
}

@end
