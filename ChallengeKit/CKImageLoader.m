//
//  CKSoundCloudImageLoader.m
//  Challenge
//
//  Created by Diana Gren on 4/17/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import "CKImageLoader.h"

@interface CKImageLoader ()
@property (strong, nonatomic) NSURLSessionDataTask *task;
@end

@implementation CKImageLoader

+ (NSCache *)sharedCache {
  static NSCache *imageCache = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    imageCache = [[NSCache alloc] init];
  });
  return imageCache;
}

- (void)loadImageWithURL:(NSURL *)url {
  UIImage *image = [self _cahcedImageForURL:url];
  if (image) {
    [self _didLoadImage:image];
  } else {
    [self _loadImageFromURL:url];
  }
}

- (void)cancel {
  [self.task cancel];
}

#pragma mark Private

- (UIImage *)_cahcedImageForURL:(NSURL *)url {
  NSData *data = [[[self class] sharedCache] objectForKey:url];
  return [UIImage imageWithData:data];
}


- (void)_loadImageFromURL:(NSURL *)url {
  NSURLSession *session = [NSURLSession sharedSession];
  [self.task cancel];
  self.task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error) {
      NSLog(@"Image loading error: %@", error.localizedDescription);
      return;
    }

    [[[self class] sharedCache] setObject:data forKey:url];
    dispatch_async(dispatch_get_main_queue(), ^{
      UIImage *image = [UIImage imageWithData:data];
      if (image) {
        [self _didLoadImage:image];
      }
    });
  }];
  [self.task resume];
}

- (void)_didLoadImage:(UIImage *)image {
  id<CKImageLoaderDelegate> delegate = self.delegate;
  [delegate imageLoader:self didLoadImage:image];
}

@end
