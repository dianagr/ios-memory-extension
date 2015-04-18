//
//  CKSoundCloudImageLoader.h
//  Challenge
//
//  Created by Diana Gren on 4/17/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CKImageLoader;
@protocol CKImageLoaderDelegate <NSObject>
- (void)imageLoader:(CKImageLoader *)imageLoader didLoadImage:(UIImage *)image;
@end

@interface CKImageLoader : NSObject

@property (weak, nonatomic) id<CKImageLoaderDelegate> delegate;

- (void)loadImageWithURL:(NSURL *)url;
- (void)cancel;

@end
