//
//  SCUserRequest.h
//  Challenge
//
//  Created by D Gren on 4/25/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import "SCRequest.h"

@interface SCUserRequest : SCRequest

/*! Creates an HTTP GET request for the /user/{id}/tracks path, listing the user's tracks. Calls a handler upon completion.
 @param userId The user id to list tracks for.
 @param completion Completion handler that's called after data has been fetched.
 */
+ (instancetype)newTracksListRequestForUserId:(NSNumber *)userId completion:(SCRequestCompletion)completion;

@end
