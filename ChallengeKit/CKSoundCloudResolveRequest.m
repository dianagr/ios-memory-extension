//
//  CKSoundCloudResolveRequest.m
//  Challenge
//
//  Created by Diana Gren on 4/8/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import "CKSoundCloudResolveRequest.h"

@implementation CKSoundCloudResolveRequest

+ (instancetype)newRequestWithPermalink:(NSURL *)permalink completion:(CKSoundCloudRequestCompletion)completion {
  return [self newRequestGETWithPath:@"resolve" params:@{@"url": permalink} completion:completion];
}

@end
