//
//  SCResolveRequest.h
//  Challenge
//
//  Created by D Gren on 4/25/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import "SCRequest.h"

@interface SCResolveRequest : SCRequest

/*! Creates an HTTP GET request for the /resolve path, then calls a handler upon completion.
 @param resolveURL The URL to resolve, passed in as the 'url' parameter.
 @param completion Completion handler that's called after data has been fetched.
 */
+ (instancetype)newRequestWithResolveURL:(NSURL *)resolveURL completion:(SCRequestCompletion)completion;

@end
