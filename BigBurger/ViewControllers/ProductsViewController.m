//
//  ProductsViewController.m
//  BigBurger
//
//  Created by Telolahy on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import "ProductsViewController.h"
#import "OrderViewController.h"

@implementation ProductsViewController
{
    Order *_order;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // viewController title
    self.title = @"Products";
    
    // Order button on NavigationBar
    UIBarButtonItem *orderButton = [[UIBarButtonItem alloc] initWithTitle:@"Order" style:UIBarButtonItemStylePlain target:self action:@selector(orderButtonTouchUpInside:)];
    self.navigationItem.rightBarButtonItem = orderButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Target action

- (void)orderButtonTouchUpInside:(id)sender
{
    // Navigate to order ViewController by passing current order object
    OrderViewController *orderViewController = [[OrderViewController alloc] init];
    orderViewController.order = _order;
    [self.navigationController pushViewController:orderViewController animated:YES];
}


@end
