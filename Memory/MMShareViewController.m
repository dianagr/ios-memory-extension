//
//  ShareViewController.m
//  Memory
//
//  Created by Diana Gren on 4/5/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import "MMShareViewController.h"

#import "MMCollectionViewCell.h"
#import "MMCollectionViewController.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <ChallengeKit/ChallengeKit.h>

static const NSInteger kMMUIiewAnimationDuration = 0.2;

@interface MMShareViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) MMCollectionViewController *collectionViewController;
@end

@implementation MMShareViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  NSExtensionItem *extensionItem = self.extensionContext.inputItems.firstObject;
  for (NSItemProvider *itemProvider in extensionItem.attachments) {
    if ([itemProvider hasItemConformingToTypeIdentifier:(__bridge NSString *)kUTTypePlainText]) {
      [itemProvider loadItemForTypeIdentifier:(__bridge NSString *)kUTTypePlainText options:nil completionHandler:^(NSString *item, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
          self.titleLabel.text = item;
        });
      }];
    } else if ([itemProvider hasItemConformingToTypeIdentifier:(__bridge NSString *)kUTTypeURL]) {
      [itemProvider loadItemForTypeIdentifier:(__bridge NSString *)kUTTypeURL options:nil completionHandler:^(NSURL *item, NSError *error) {
        CKSoundCloudResolveRequest *request = [CKSoundCloudResolveRequest newRequestWithPermalink:item completion:^(id response, NSError *requestError) {
          NSLog(@"LOADED URL: %@", response);
        }];
        [request resume];
      }];
    }
  }
  self.collectionView.dataSource = self.collectionViewController;
  self.collectionView.delegate = self.collectionViewController;
  [self.collectionView registerClass:[MMCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MMCollectionViewCell class])];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.view.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height);
  [UIView animateWithDuration:kMMUIiewAnimationDuration animations:^{
    self.view.transform = CGAffineTransformIdentity;
  }];
}

- (MMCollectionViewController *)collectionViewController {
  if (!_collectionViewController) {
    _collectionViewController = [MMCollectionViewController new];
  }
  return _collectionViewController;
}

- (IBAction)didTapCancel:(UIButton *)sender {
  [UIView animateWithDuration:kMMUIiewAnimationDuration animations:^{
    self.view.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height);
  } completion:^(BOOL finished) {
    [self.extensionContext completeRequestReturningItems:nil completionHandler:nil];
  }];
}

@end
