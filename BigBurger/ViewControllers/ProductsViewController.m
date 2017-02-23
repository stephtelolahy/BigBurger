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

@interface ProductsViewController()<ProductsManagerDelegate, UITableViewDataSource>

@end

@implementation ProductsViewController
{
    ProductsManager *_productsManager;
    NSArray *_products;
    Order *_order;
    
    __weak IBOutlet UITableView *_tableView;
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
    
    // setup tableView
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseId"];
    _tableView.dataSource = self;
    
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
    
    // reload tableView
    _products = products;
    [_tableView reloadData];
}

- (void)productsManager:(ProductsManager *)manager didFail:(NSError *)error
{
    // TODO: hide loadingView
    
    // show errorView
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Product *product = _products[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseId"];
    cell.textLabel.text = product.title;
    
    return cell;
}

@end
