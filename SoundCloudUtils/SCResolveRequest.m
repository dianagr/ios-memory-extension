//
//  SCResolveRequest.m
//  Challenge
//
//  Created by Diana Gren on 4/25/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import "SCResolveRequest.h"

@implementation SCResolveRequest

+ (instancetype)newRequestWithResolveURL:(NSURL *)resolveURL completion:(SCRequestCompletion)completion {
  return [self newRequestGETWithPath:@"resolve" params:@{@"url": resolveURL} completion:completion];
}

@end
