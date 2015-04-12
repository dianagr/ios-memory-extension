//
//  CKSoundCloudUserRequest.m
//  Challenge
//
//  Created by Diana Gren on 4/12/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import "CKSoundCloudUserRequest.h"

@implementation CKSoundCloudUserRequest

+ (instancetype)newTracksListRequestForUserId:(NSString *)userId completion:(CKSoundCloudRequestCompletion)completion {
  NSString *path = [NSString stringWithFormat:@"users/%@/tracks", userId];
  return [self newRequestGETWithPath:path params:nil completion:completion];
}

@end
