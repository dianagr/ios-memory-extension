//
//  SCImageLoader.h
//  Challenge
//
//  Created by Diana Gren on 4/25/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SCImageLoader;
@protocol SCImageLoaderDelegate <NSObject>
- (void)imageLoader:(SCImageLoader *)imageLoader didLoadImage:(UIImage *)image;
@end

@interface SCImageLoader : NSObject

@property (weak, nonatomic) id<SCImageLoaderDelegate> delegate;

- (void)loadImageWithURL:(NSURL *)url;
- (void)cancel;

@end