//
//  NSDictionary+SCAPI.h
//  Challenge
//
//  Created by D Gren on 4/25/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Category for SoundCloud API specific fields in the JSON object.
@interface NSDictionary (SCAPI)

@property (readonly, copy, nonatomic) NSNumber *userId;
@property (readonly, copy, nonatomic) NSURL *artworkURL;

@end
