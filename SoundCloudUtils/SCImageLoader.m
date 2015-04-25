//
//  SCImageLoader.m
//  Challenge
//
//  Created by Diana Gren on 4/25/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import "SCImageLoader.h"

@interface SCImageLoader ()
@property (strong, nonatomic) NSURLSessionDataTask *task;
@end

@implementation SCImageLoader

+ (NSCache *)sharedCache {
  static NSCache *gImageCache = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    gImageCache = [[NSCache alloc] init];
  });
  return gImageCache;
}

- (void)loadImageWithURL:(NSURL *)url {
  UIImage *image = [self _cachedImageForURL:url];
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

- (UIImage *)_cachedImageForURL:(NSURL *)url {
  NSData *data = [[[self class] sharedCache] objectForKey:url];
  return [UIImage imageWithData:data];
}


- (void)_loadImageFromURL:(NSURL *)url {
  NSURLSession *session = [NSURLSession sharedSession];
  [self.task cancel];
  self.task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error) {
      NSLog(@"Image loading error: %@, URL: %@", error.localizedDescription, response.URL);
      [self _didError:error];
    } else {
      [[[self class] sharedCache] setObject:data forKey:url];
      [self _didLoadImage:[UIImage imageWithData:data]];
    }
  }];
  [self.task resume];
}

- (void)_didLoadImage:(UIImage *)image {
  dispatch_async(dispatch_get_main_queue(), ^{
    id<SCImageLoaderDelegate> delegate = self.delegate;
    [delegate imageLoader:self didLoadImage:image];
  });
}

- (void)_didError:(NSError *)error {
  dispatch_async(dispatch_get_main_queue(), ^{
    id<SCImageLoaderDelegate> delegate = self.delegate;
    [delegate imageLoader:self didError:error];
  });
}

@end
