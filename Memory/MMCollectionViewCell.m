//
//  MMCollectionViewCell.m
//  Challenge
//
//  Created by Diana Gren on 4/11/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import "MMCollectionViewCell.h"

#import "CKImageLoader.h"
#import <ChallengeKit/ChallengeKit.h>

static const CGFloat kDefaultCornerRadius = 4;
static const CGFloat kDefaultBorderWidth = 0.5;

@interface MMCollectionViewCell () <CKImageLoaderDelegate>
@property (strong, nonatomic) UIImageView *backImageView;
@property (strong, nonatomic) UIImageView *frontImageView;
@property (strong, nonatomic) CKImageLoader *imageLoader;
@end

@implementation MMCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.contentView.layer.cornerRadius = kDefaultCornerRadius;
    self.contentView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.contentView.layer.borderWidth = kDefaultBorderWidth;
    self.contentView.layer.masksToBounds = YES;

    _backImageView = [UIImageView new];
    _backImageView.contentMode = UIViewContentModeScaleToFill;
    _backImageView.image = [UIImage imageNamed:@"back"];
    [self.contentView addSubview:_backImageView];

    _frontImageView = [UIImageView new];
    _frontImageView.contentMode = UIViewContentModeScaleToFill;
    _frontImageView.hidden = YES;
    [self.contentView addSubview:_frontImageView];

    _backImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _frontImageView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = NSDictionaryOfVariableBindings(_backImageView, _frontImageView);
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_backImageView]|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_backImageView]|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_frontImageView]|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_frontImageView]|" options:0 metrics:nil views:views]];
  }
  return self;
}

- (void)prepareForReuse {
  [super prepareForReuse];
  [self.imageLoader cancel];
  self.imageLoader.delegate = nil;
}

- (void)setFlippedUp:(BOOL)flippedUp {
  _flippedUp = flippedUp;
  self.backImageView.hidden = flippedUp;
  self.frontImageView.hidden = !flippedUp;
}

- (void)setTrack:(NSDictionary *)track {
  self.imageLoader.delegate = self;
  [self.imageLoader loadImageWithURL:[NSURL URLWithString:track[[CKSoundCloud artworkURLKey]]]];
}

- (CKImageLoader *)imageLoader {
  if (!_imageLoader) {
    _imageLoader = [[CKImageLoader alloc] init];
  }
  return _imageLoader;
}

#pragma mark CKImageLoaderDelegate

- (void)imageLoader:(CKImageLoader *)imageLoader didLoadImage:(UIImage *)image {
  self.frontImageView.image = image;
}

@end
