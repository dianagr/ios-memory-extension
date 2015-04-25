//
//  SCResolveRequest.m
//  Challenge
//
//  Created by D Gren on 4/25/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import "SCResolveRequest.h"

@implementation SCResolveRequest

+ (instancetype)newRequestWithResolveURL:(NSURL *)resolveURL completion:(SCRequestCompletion)completion {
  return [self newRequestGETWithPath:@"resolve" params:@{@"url": resolveURL} completion:completion];
}

@end
