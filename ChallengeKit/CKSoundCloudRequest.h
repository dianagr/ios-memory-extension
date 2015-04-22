//
//  CKSoundCloudRequest.h
//  Challenge
//
//  Created by D Gren on 4/8/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CKSoundCloudRequestCompletion)(id response, NSError *error);

@interface CKSoundCloudRequest : NSObject

@property (readonly, strong, nonatomic) NSURLSessionDataTask *task;

/*! Creates an HTTP GET request for the specified path, then calls a handler upon completion.
 @param path The path in the SoundCloud API to call.
 @param params The query parameters to use in the GET request.
 @param completion Completion handler that's called after data has been fetched.
 */
+ (instancetype)newRequestGETWithPath:(NSString *)path params:(NSDictionary *)params completion:(CKSoundCloudRequestCompletion)completion;

//! Resumes the request, if it is suspended.
- (void)resume;

//! Cancels the request.
- (void)cancel;

@end
