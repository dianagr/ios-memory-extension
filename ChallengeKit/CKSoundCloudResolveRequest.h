//
//  CKSoundCloudResolveRequest.h
//  Challenge
//
//  Created by Diana Gren on 4/8/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import "CKSoundCloudRequest.h"

@interface CKSoundCloudResolveRequest : CKSoundCloudRequest

- (void)loadWithPermalink:(NSURL *)permalink completion:(CKSoundCloudRequestCompletion)completion;

@end
