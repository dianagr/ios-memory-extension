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

#pragma mark API fields

+ (NSString *)clientId {
  return [self _apiAuthenticationCredentials][[self clientIdKey]];
}

+ (NSString *)clientIdKey {
  return @"client_id";
}

@end
