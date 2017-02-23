//
//  OrderViewController.m
//  BigBurger
//
//  Created by Telolahy on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import "OrderViewController.h"
#import "ProductRowTableViewCell.h"
#import "UIViewController+Toast.h"

@interface OrderViewController ()<UITableViewDataSource, UITableViewDelegate, ProductRowTableViewCellDelegate>

@end

@implementation OrderViewController
{
    __weak IBOutlet UITableView *_tableView;
    __weak IBOutlet UIButton *_submitButton;
    __weak IBOutlet UILabel *_emptyView;
}

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Order details", @"order details title");
    
    // setup tableView
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ProductRowTableViewCell class]) bundle:nil] forCellReuseIdentifier:ProductRowTableViewCellReuseIdentifier];
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
    [self updateViews];
}

#pragma mark - IBAction

- (IBAction)submitButtonTouchUpInside:(id)sender
{
    [self showToast:NSLocalizedString(@"Your order has been validated", @"order submitted message")];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _order.productRows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductRowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductRowTableViewCellReuseIdentifier];
    ProductRow *productRow = _order.productRows[indexPath.row];
    [cell updateWithProductRow:productRow];
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

#pragma mark - ProductRowTableViewCellDelegate

- (void)productRowTableViewCell:(ProductRowTableViewCell *)cell didIncrement:(Product *)product
{
    [_order incrementProduct:product];
    [self updateViews];
}

- (void)productRowTableViewCell:(ProductRowTableViewCell *)cell didDecrement:(Product *)product
{
    [_order decrementProduct:product];
    [self updateViews];
}

- (void)productRowTableViewCell:(ProductRowTableViewCell *)cell didDelete:(Product *)product
{
    [_order removeProductRow:product];
    [self updateViews];
}

#pragma mark - Private

- (void)updateViews
{
    [_tableView reloadData];
    [_submitButton setTitle:[NSString stringWithFormat:NSLocalizedString(@"Payer %.2f €", @"submit button"), _order.totalPrice] forState:UIControlStateNormal];
    _emptyView.hidden = _order.totalQuantity > 0;
}


@end
