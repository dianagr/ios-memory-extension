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
#import "MMGameSet.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <ChallengeKit/ChallengeKit.h>

static const CGFloat kMMUIiewAnimationDuration = 0.2;

@interface MMShareViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
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
        [self _resolvePermalink:item];
      }];
    }
  }
  self.collectionView.dataSource = self.collectionViewController;
  self.collectionView.delegate = self.collectionViewController;
  [self.collectionView registerClass:[MMCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MMCollectionViewCell class])];
}

- (MMCollectionViewController *)collectionViewController {
  if (!_collectionViewController) {
    _collectionViewController = [MMCollectionViewController new];
  }
  return _collectionViewController;
}

#pragma mark Private

- (IBAction)didTapCancel:(UIButton *)sender {
  self.view.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height);
  [self.extensionContext completeRequestReturningItems:nil completionHandler:nil];
}

- (void)_resolvePermalink:(NSURL *)url {
  CKSoundCloudRequest *request = [CKSoundCloudResolveRequest newRequestWithResolveURL:url completion:^(NSDictionary *response, NSError *requestError) {
    [self _loadTracksForUserId:response[[CKSoundCloud userIdKey]]];
  }];
  [request resume];
}

- (void)_loadTracksForUserId:(NSString *)userId {
  CKSoundCloudRequest *request = [CKSoundCloudUserRequest newTracksListRequestForUserId:userId completion:^(NSArray *response, NSError *error) {
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.collectionViewController setTracks:[MMGameSet gameSetFromItems:response]];
      [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
      [self.activityIndicator stopAnimating];
    });
  }];
  [request resume];
}

@end
