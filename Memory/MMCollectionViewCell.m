//
//  MMCollectionViewCell.m
//  Challenge
//
//  Created by Diana Gren on 4/11/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import "MMCollectionViewCell.h"

static const CGFloat kDefaultCornerRadius = 4;
static const CGFloat kDefaultBorderWidth = 0.5;

@interface MMCollectionViewCell ()
@property (strong, nonatomic) UIImageView *backImageView;
@end

@implementation MMCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.contentView.layer.cornerRadius = kDefaultCornerRadius;
    self.contentView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.contentView.layer.borderWidth = kDefaultBorderWidth;

    _backImageView = [UIImageView new];
    _backImageView.contentMode = UIViewContentModeScaleToFill;
    _backImageView.image = [UIImage imageNamed:@"back"];
    [self.contentView addSubview:_backImageView];

    _backImageView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = NSDictionaryOfVariableBindings(_backImageView);
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_backImageView]|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_backImageView]|" options:0 metrics:nil views:views]];
  }
  return self;
}

- (void)setFlippedUp:(BOOL)flippedUp {
  _flippedUp = flippedUp;
  self.backImageView.hidden = flippedUp;
}

@end
