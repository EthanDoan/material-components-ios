// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
#import <UIKit/UIKit.h>

#import "MaterialCollections.h"
#import "MaterialColorScheme.h"
#import "MaterialDialogs+DialogThemer.h"
#import "MaterialDialogs.h"
#import "MaterialTypographyScheme.h"

#pragma mark - DialogsTypicalUseViewController

@interface DialogsTypicalUseViewController : UIViewController
@property(nonatomic, strong, nullable) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong, nullable) MDCTypographyScheme *typographyScheme;
@property(nonatomic, strong, nullable) MDCButtonScheme *buttonScheme;
@property(nonatomic, strong, nullable) MDCAlertScheme *alertScheme;
@property(nonatomic, strong, nullable) NSArray *modes;
@property(nonatomic, strong, nullable) MDCButton *button;
@end

@implementation DialogsTypicalUseViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  if (!self.colorScheme) {
    self.colorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }
  if (!self.typographyScheme) {
    self.typographyScheme = [[MDCTypographyScheme alloc] init];
  }
  if (!self.buttonScheme) {
    self.buttonScheme = [[MDCButtonScheme alloc] init];
    self.buttonScheme.colorScheme = self.colorScheme;
    self.buttonScheme.typographyScheme = self.typographyScheme;
    self.buttonScheme.shapeScheme = [[MDCShapeScheme alloc] init];
  }
  if (!self.alertScheme) {
    self.alertScheme = [[MDCAlertScheme alloc] init];
    self.alertScheme.colorScheme = self.colorScheme;
    self.alertScheme.typographyScheme = self.typographyScheme;
    self.alertScheme.buttonScheme = self.buttonScheme;
  }

  self.view.backgroundColor = self.colorScheme.backgroundColor;

  MDCButton *dismissButton = [[MDCButton alloc] initWithFrame:CGRectZero];
  self.button = dismissButton;
  dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
  [dismissButton setTitle:@"Show Alert Dialog" forState:UIControlStateNormal];
  [dismissButton addTarget:self
                    action:@selector(showAlert:)
          forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:dismissButton];

  [MDCTextButtonThemer applyScheme:self.buttonScheme toButton:dismissButton];

  [self.view addConstraints:@[
    [NSLayoutConstraint constraintWithItem:dismissButton
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0.0],
    [NSLayoutConstraint constraintWithItem:dismissButton
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0
                                  constant:0.0]
  ]];
}

- (void)showAlert:(UIButton *)button {
  NSString *titleString = @"Reset Settings?";
  NSString *messageString = @"This will reset your device to its default factory settings.";

  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:titleString
                                                                   message:messageString];
  alert.mdc_adjustsFontForContentSizeCategory = YES;

  MDCActionHandler handler = ^(MDCAlertAction *action) {
    NSLog(@"action pressed: %@", action.title);
  };

  MDCAlertAction *agreeAaction = [MDCAlertAction actionWithTitle:@"Cancel"
                                                        emphasis:MDCActionEmphasisLow
                                                         handler:handler];
  [alert addAction:agreeAaction];

  MDCAlertAction *disagreeAaction = [MDCAlertAction actionWithTitle:@"Accept"
                                                           emphasis:MDCActionEmphasisLow
                                                            handler:handler];
  [alert addAction:disagreeAaction];
  [MDCAlertControllerThemer applyScheme:self.alertScheme toAlertController:alert];

  [self presentViewController:alert animated:YES completion:NULL];
}

@end

#pragma mark - DialogsTypicalUseViewController - CatalogByConvention

@implementation DialogsTypicalUseViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Dialogs", @"Dialogs (Catalog)" ],
    @"description" : @"Dialogs inform users about a task and can contain critical information, "
                     @"require decisions, or involve multiple tasks.",
    @"primaryDemo" : @YES,
    @"presentable" : @YES,
  };
}

@end
