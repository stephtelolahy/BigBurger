//
//  OrderViewController.m
//  BigBurger
//
//  Created by Telolahy on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import "OrderViewController.h"
#import "ProductRowTableViewCell.h"
#import "MBProgressHUD.h"

@interface OrderViewController ()<UITableViewDataSource, UITableViewDelegate, ProductRowTableViewCellDelegate>

@end

@implementation OrderViewController
{
    __weak IBOutlet UITableView *_tableView;
    __weak IBOutlet UIButton *_submitButton;
    
}

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Order", @"order title");
    
    // Setup submit button
    [self updateSubmitButton];
    
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


#pragma mark - IBAction

- (IBAction)submitButtonTouchUpInside:(id)sender
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = NSLocalizedString(@"Your order has been validated", @"order submitted message");
    hud.margin = 10.f;
    hud.offset = CGPointMake(hud.offset.x, 150);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1];
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
}

- (void)productRowTableViewCell:(ProductRowTableViewCell *)cell didDecrement:(Product *)product
{
}

- (void)productRowTableViewCell:(ProductRowTableViewCell *)cell didDelete:(Product *)product
{
}

#pragma mark - Private

- (void)updateSubmitButton
{
    [_submitButton setTitle:[NSString stringWithFormat:NSLocalizedString(@"Payer %.2f €", @"submit button"), _order.totalPrice] forState:UIControlStateNormal];
    _submitButton.enabled = _order.totalQuantity > 0;
}


@end
