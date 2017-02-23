//
//  ProductsViewController.m
//  BigBurger
//
//  Created by Telolahy on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import "ProductsViewController.h"
#import "ProductsManager.h"
#import "OrderViewController.h"

@interface ProductsViewController()<ProductsManagerDelegate>

@end

@implementation ProductsViewController
{
    ProductsManager *_productsManager;
    NSArray *_products;
    Order *_order;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // viewController title
    self.title = NSLocalizedString(@"Products", @"products title");
    
    // Order button on NavigationBar
    UIBarButtonItem *orderButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Order", @"order title") style:UIBarButtonItemStylePlain target:self action:@selector(orderButtonTouchUpInside:)];
    self.navigationItem.rightBarButtonItem = orderButton;
    
    // Init objetcs
    _productsManager = [[ProductsManager alloc] init];
    _productsManager.delegate = self;
    _order = [[Order alloc] init];
    
    // TODO: setup tableView
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [_productsManager fetchProducts];
    
    // TODO: show loadingView
}


#pragma mark - Target action

- (void)orderButtonTouchUpInside:(id)sender
{
    // Navigate to order ViewController by passing builded order object
    OrderViewController *orderViewController = [[OrderViewController alloc] init];
    orderViewController.order = _order;
    [self.navigationController pushViewController:orderViewController animated:YES];
}


#pragma mark - ProductsManagerDelegate

- (void)productsManager:(ProductsManager *)manager didSucceed:(NSArray *)products
{
    // TODO: hide loadingView
    // TODO: reload tableView
}

- (void)productsManager:(ProductsManager *)manager didFail:(NSError *)error
{
    // TODO: hide loadingView
    // TODO: show errorView
}

@end
