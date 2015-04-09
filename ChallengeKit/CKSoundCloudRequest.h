//
//  CKSoundCloudRequest.h
//  Challenge
//
//  Created by Diana Gren on 4/8/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CKSoundCloudRequestCompletion)(id response);

@interface CKSoundCloudRequest : NSObject

@property (readonly, strong, nonatomic) NSURLSessionDataTask *task;

- (void)requestHTTPGetWithPath:(NSString *)path params:(NSDictionary *)params completion:(CKSoundCloudRequestCompletion)completion;

@end
