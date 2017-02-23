//
//  OrderViewController.h
//  BigBurger
//
//  Created by Telolahy on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

@interface OrderViewController : UIViewController

// The order object to display, set by presenting viewController
@property (strong, nonatomic)   Order *order;

@end
