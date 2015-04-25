//
//  SCAPI.h
//  Challenge
//
//  Created by Diana Gren on 4/25/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCAPI : NSObject

+ (NSString *)scheme;

+ (NSString *)host;

+ (NSString *)clientId;

#pragma mark API fields

+ (NSString *)clientIdKey;

+ (NSString *)userIdKey;

+ (NSString *)artworkURLKey;

@end
