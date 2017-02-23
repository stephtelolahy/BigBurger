//
//  UIViewController+Toast.h
//  BigBurger
//
//  Created by Stéphano TELOLAHY on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController(Toast)

// display a brief message
- (void)showToast:(NSString *)message;

// show a MBProgressHUD
- (void)showLoadingView;

// hide associated MBProgressHUD
- (void)hideLoadingView;

@end
