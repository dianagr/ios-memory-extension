//
//  CKSoundCloud.h
//  Challenge
//
//  Created by Diana Gren on 4/8/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CKSoundCloud : NSObject

+ (NSString *)host;

+ (NSString *)clientId;

#pragma mark API fields

+ (NSString *)clientIdKey;

+ (NSString *)userIdKey;

@end
