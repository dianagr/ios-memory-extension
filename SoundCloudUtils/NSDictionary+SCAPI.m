//
//  NSDictionary+SCAPI.m
//  Challenge
//
//  Created by D Gren on 4/25/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import "NSDictionary+SCAPI.h"

#import "SCAPI.h"

@implementation NSDictionary (SCAPI)

- (NSNumber *)userId {
  id object = self[kSCAPIFieldUserId];
  if ([object isKindOfClass:[NSNumber class]]) {
    return (NSNumber *)object;
  }
  return nil;
}

- (NSURL *)artworkURL {
  return [NSURL URLWithString:self[kSCAPIFieldArtworkURL]];
}

@end
