//
//  MMCollectionViewCell.m
//  Challenge
//
//  Created by Diana Gren on 4/11/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import "MMCollectionViewCell.h"

@interface MMCollectionViewCell ()
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation MMCollectionViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
  self.imageView = [UIImageView new];
  self.imageView.alpha = 0.7;
  self.imageView.contentMode = UIViewContentModeScaleToFill;
  self.imageView.image = [UIImage imageNamed:@"back"];
  self.imageView.layer.masksToBounds = YES;
  self.imageView.layer.cornerRadius = 4;
  [self.contentView addSubview:self.imageView];

  self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
  NSDictionary *views = NSDictionaryOfVariableBindings(_imageView);
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_imageView]|" options:0 metrics:nil views:views]];
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imageView]|" options:0 metrics:nil views:views]];
}

@end
