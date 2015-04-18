//
//  CKSoundCloud.m
//  Challenge
//
//  Created by Diana Gren on 4/8/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import "CKSoundCloud.h"

@implementation CKSoundCloud

+ (NSString *)host {
  return @"https://api.soundcloud.com";
}

#pragma mark Client Id

+ (NSDictionary *)_apiAuthenticationCredentials {
  static NSDictionary *authCredentials = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    authCredentials = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"api_key" ofType:@"plist"]];
  });
  return authCredentials;
}

+ (NSString *)clientId {
  return [self _apiAuthenticationCredentials][[self clientIdKey]];
}

#pragma mark API fields

+ (NSString *)clientIdKey {
  return @"client_id";
}

+ (NSString *)userIdKey {
  return @"user_id";
}

+ (NSString *)artworkURLKey {
  return @"artwork_url";
}

@end
