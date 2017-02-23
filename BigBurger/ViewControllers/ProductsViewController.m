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
#import "ProductTableViewCell.h"

@interface ProductsViewController()<UITableViewDataSource, UITableViewDelegate, ProductsManagerDelegate, ProductTableViewCellDelegate>

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
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ProductTableViewCell class]) bundle:nil] forCellReuseIdentifier:ProductTableViewCellReuseIdetifier];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
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
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductTableViewCellReuseIdetifier];
    Product *product = _products[indexPath.row];
    [cell updateWithProduct:product];
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//}
//
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
//
//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 44;
//}


#pragma mark - ProductTableViewCellDelegate

- (void)productTableViewCell:(ProductTableViewCell *)cell didAddProduct:(Product *)product
{
    // TODO: add product to order
}

@end
