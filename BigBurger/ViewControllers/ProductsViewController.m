//
//  ProductsViewController.m
//  BigBurger
//
//  Created by Telolahy on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import "ProductsViewController.h"
#import "OrderViewController.h"
#import "ProductTableViewCell.h"
#import "ProductsManager.h"
#import "UIViewController+Toast.h"

@interface ProductsViewController()<UITableViewDataSource, UITableViewDelegate, ProductsManagerDelegate, ProductTableViewCellDelegate>

@end

@implementation ProductsViewController
{
    ProductsManager *_productsManager;
    NSArray *_products;
    Order *_order;
    
    __weak IBOutlet UITableView *_tableView;
    __weak UIBarButtonItem *_orderButton;
    __weak IBOutlet UIView *_errorView;
    __weak IBOutlet UILabel *_errorLabel;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // viewController title
    self.title = NSLocalizedString(@"Products", @"products title");
    
    // Order button on NavigationBar
    UIBarButtonItem *orderButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Order", @"order title") style:UIBarButtonItemStylePlain target:self action:@selector(orderButtonTouchUpInside:)];
    self.navigationItem.rightBarButtonItem = orderButton;
    _orderButton = orderButton;
    
    // Init objetcs
    _productsManager = [[ProductsManager alloc] init];
    _productsManager.delegate = self;
    _order = [[Order alloc] init];
    
    // setup tableView
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ProductTableViewCell class]) bundle:nil] forCellReuseIdentifier:ProductTableViewCellReuseIdetifier];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 44;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    // remove extra separators
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!_products)
    {
        [_productsManager fetchProducts];
        
        [self showLoadingView];
    }
    
    [self updateOrderButton];
}


#pragma mark - Target action

- (void)orderButtonTouchUpInside:(id)sender
{
    // Navigate to order ViewController by passing builded order object
    OrderViewController *orderViewController = [[OrderViewController alloc] init];
    orderViewController.order = _order;
    [self.navigationController pushViewController:orderViewController animated:YES];
}


#pragma mark - IBAction

- (IBAction)retryButtonTouchUpInside:(id)sender
{
    [_productsManager fetchProducts];
    _errorView.hidden = YES;
    [self showLoadingView];
}


#pragma mark - ProductsManagerDelegate

- (void)productsManager:(ProductsManager *)manager didSucceed:(NSArray *)products
{
    [self hideLoadingView];
    
    if (products.count == 0)
    {
        _errorView.hidden = NO;
        _errorLabel.text = NSLocalizedString(@"No products found", @"empty products message");
    }
    else
    {
        // reload tableView
        _products = products;
        [_tableView reloadData];
    }
}

- (void)productsManager:(ProductsManager *)manager didFail:(NSError *)error
{
    [self hideLoadingView];
    
    _errorView.hidden = NO;
    _errorLabel.text = [error localizedDescription];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}


#pragma mark - ProductTableViewCellDelegate

- (void)productTableViewCell:(ProductTableViewCell *)cell didAddProduct:(Product *)product
{
    // add product to order
    [_order incrementProduct:product];
    [self updateOrderButton];
    
    // display product added to order message
    [self showToast:[NSString stringWithFormat:NSLocalizedString(@"Added %@", @"product added to order message"), product.title]];
}


#pragma mark - Private

- (void)updateOrderButton
{
    _orderButton.title = [NSString stringWithFormat:NSLocalizedString(@"Order(%d)", @"order title with quantity"), _order.totalQuantity] ;
}

@end
