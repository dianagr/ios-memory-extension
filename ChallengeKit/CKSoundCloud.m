//
//  CKSoundCloud.m
//  Challenge
//
//  Created by Diana Gren on 4/8/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import "CKSoundCloud.h"

@implementation CKSoundCloud

+ (NSString *)clientId {
  return [self _apiAuthenticationCredentials][@"client_id"];
}

+ (NSDictionary *)_apiAuthenticationCredentials {
  static NSDictionary *authCredentials = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    authCredentials = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"api_key" ofType:@"plist"]];
  });
  return authCredentials;
}

@end
