//
//  UIViewController+Toast.m
//  BigBurger
//
//  Created by Stéphano TELOLAHY on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import "UIViewController+Toast.h"
#import "MBProgressHUD.h"


@implementation UIViewController(Toast)

- (void)showToast:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.margin = 10.f;
    hud.offset = CGPointMake(hud.offset.x, 150);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1];
}

- (void)showLoadingView
{
    MBProgressHUD* hud = [MBProgressHUD HUDForView:self.view];
    if (hud == nil) {
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = NSLocalizedString(@"Loading ...", @"loading message");
    }
}

- (void)hideLoadingView
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
