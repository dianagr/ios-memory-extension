//
//  SCUserRequest.m
//  Challenge
//
//  Created by Diana Gren on 4/25/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import "SCUserRequest.h"

@implementation SCUserRequest

+ (instancetype)newTracksListRequestForUserId:(NSString *)userId completion:(SCRequestCompletion)completion {
  NSString *path = [NSString stringWithFormat:@"users/%@/tracks", userId];
  return [self newRequestGETWithPath:path params:nil completion:completion];
}

@end
