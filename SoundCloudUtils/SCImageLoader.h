//
//  SCImageLoader.h
//  Challenge
//
//  Created by D Gren on 4/25/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SCImageLoader;
@protocol SCImageLoaderDelegate <NSObject>
@optional
/*! Tells the delegate that the image has been loaded.
 @param imageLoader
 @param image The resulted image if success.
 */
- (void)imageLoader:(SCImageLoader *)imageLoader didLoadImage:(UIImage *)image;

/*! Tells the delegate that an error occured whtn loading the image.
 @param imageLoader
 @param error Occurred error.
 */
- (void)imageLoader:(SCImageLoader *)imageLoader didError:(NSError *)error;

@end

@interface SCImageLoader : NSObject

@property (weak, nonatomic) id<SCImageLoaderDelegate> delegate;

/*! Load image located at specified URL.
 @param url Location of the image.
 @discussion This method will hit the network to fetch image data, which will be cached. Hitting the same URL will load the image from the cache.
 */
- (void)loadImageWithURL:(NSURL *)url;

//! Cancel the task loading the image data.
- (void)cancel;

@end