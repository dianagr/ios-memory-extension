//
//  ShareViewController.m
//  Memory
//
//  Created by Diana Gren on 4/5/15.
//  Copyright (c) 2015 Diana Gren. All rights reserved.
//

#import "MMShareViewController.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <ChallengeKit/ChallengeKit.h>

static const NSInteger kMMUIiewAnimationDuration = 0.2;

@interface MMShareViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation MMShareViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  NSExtensionItem *extensionItem = self.extensionContext.inputItems.firstObject;
  NSItemProvider *itemProvider = extensionItem.attachments.firstObject;
  NSLog(@"Item: %@, provider: %@", extensionItem, itemProvider);
  for (NSItemProvider *itemProvider in extensionItem.attachments) {
    if ([itemProvider hasItemConformingToTypeIdentifier:(__bridge NSString *)kUTTypePlainText]) {
      [itemProvider loadItemForTypeIdentifier:(__bridge NSString *)kUTTypePlainText options:nil completionHandler:^(NSString *item, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
          self.title = item;
        });
        NSLog(@"Title = %@", item);
      }];
    } else if ([itemProvider hasItemConformingToTypeIdentifier:(__bridge NSString *)kUTTypeURL]) {
      [itemProvider loadItemForTypeIdentifier:(__bridge NSString *)kUTTypeURL options:nil completionHandler:^(NSURL *item, NSError *error) {
        
        NSLog(@"URL = %@", item);
        NSString *key = [CKSoundCloud clientId];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.soundcloud.com/resolve?url=%@&client_id=%@", item, key]];
        [self _loadURL:url];
      }];
    }
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.view.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height);
  [UIView animateWithDuration:kMMUIiewAnimationDuration animations:^{
    self.view.transform = CGAffineTransformIdentity;
  }];
}

- (IBAction)didTapCancel:(UIButton *)sender {
  [UIView animateWithDuration:kMMUIiewAnimationDuration animations:^{
    self.view.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height);
  } completion:^(BOOL finished) {
    
    [self.extensionContext completeRequestReturningItems:nil completionHandler:nil];
  }];
}

- (void)_loadURL:(NSURL *)url {
  NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error) {
      NSLog(@"Image loading error: %@", error.localizedDescription);
      return;
    } else {
      NSError *jsonError;
      NSJSONSerialization *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
      NSLog(@"Data: %@", jsonResponse);
    }
  }];
  [task resume];
}

@end
