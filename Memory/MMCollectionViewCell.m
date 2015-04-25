//
//  MMCollectionViewCell.m
//  Challenge
//
//  Created by D Gren on 4/11/15.
//  Copyright (c) 2015 D Gren. All rights reserved.
//

#import "MMCollectionViewCell.h"

#import <SoundCloudUtils/SoundCloudUtils.h>

static const CGFloat kDefaultCornerRadius = 4;
static const CGFloat kDefaultBorderWidth = 0.5;

@interface MMCollectionViewCell () <SCImageLoaderDelegate>
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) SCImageLoader *imageLoader;
@end

@implementation MMCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.contentView.layer.cornerRadius = kDefaultCornerRadius;
    self.contentView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.contentView.layer.borderWidth = kDefaultBorderWidth;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.backgroundColor = [UIColor whiteColor];

    _imageView = [UIImageView new];
    _imageView.contentMode = UIViewContentModeScaleToFill;
    _imageView.hidden = YES;
    [self.contentView addSubview:_imageView];

    _titleLabel = [UILabel new];
    _titleLabel.hidden = YES;
    _titleLabel.numberOfLines = 2;
    [_titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.contentView addSubview:_titleLabel];

    NSDictionary *views = NSDictionaryOfVariableBindings(_imageView, _titleLabel);
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_imageView]|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imageView][_titleLabel]|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_titleLabel]|" options:0 metrics:nil views:views]];
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
  self.imageView.hidden = !flippedUp;
}

- (void)setTrack:(NSDictionary *)track {
  self.imageLoader.delegate = self;
  [self.imageLoader loadImageWithURL:[NSURL URLWithString:track[[SCAPI artworkURLKey]]]];
}

- (SCImageLoader *)imageLoader {
  if (!_imageLoader) {
    _imageLoader = [[SCImageLoader alloc] init];
  }
  return _imageLoader;
}

#pragma mark CKImageLoaderDelegate

- (void)imageLoader:(SCImageLoader *)imageLoader didLoadImage:(UIImage *)image {
  self.imageView.image = image;
}

@end
