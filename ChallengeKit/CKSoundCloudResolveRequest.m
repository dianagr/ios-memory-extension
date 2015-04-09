//
//  CKSoundCloudResolveRequest.m
//  Challenge
//
//  Created by Diana Gren on 4/8/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import "CKSoundCloudResolveRequest.h"

@implementation CKSoundCloudResolveRequest

- (void)loadWithPermalink:(NSURL *)permalink completion:(CKSoundCloudRequestCompletion)completion {
  [self requestHTTPGetWithPath:@"resolve" params:@{ @"url": permalink } completion:completion];
}

@end
