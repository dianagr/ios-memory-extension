//
//  SCAPI.h
//  Challenge
//
//  Created by Diana Gren on 4/25/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Field for client ID used for app authorization
extern NSString *const kSCAPIFieldClientId;

//! Field for the SoundCloud user id
extern NSString *const kSCAPIFieldUserId;

//! Field for artwork URL of a track
extern NSString *const kSCAPIFieldArtworkURL;

@interface SCAPI : NSObject

+ (NSString *)scheme;

+ (NSString *)host;

//! Client ID used for authorizing the app
+ (NSString *)clientId;

@end
