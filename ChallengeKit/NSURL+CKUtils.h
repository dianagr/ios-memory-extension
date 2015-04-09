//
//  NSURL+CKUtils.h
//  Challenge
//
//  Created by Diana Gren on 4/8/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (CKUtils)

+ (instancetype)URLWithHost:(NSString *)host path:(NSString *)path queryParams:(NSDictionary *)params;

@end
