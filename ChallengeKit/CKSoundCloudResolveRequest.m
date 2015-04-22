//
//  CKSoundCloudResolveRequest.m
//  Challenge
//
//  Created by D Gren on 4/8/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import "CKSoundCloudResolveRequest.h"

@implementation CKSoundCloudResolveRequest

+ (instancetype)newRequestWithResolveURL:(NSURL *)resolveURL completion:(CKSoundCloudRequestCompletion)completion {
  return [self newRequestGETWithPath:@"resolve" params:@{@"url": resolveURL} completion:completion];
}

@end
