//
//  ProductRowTableViewCell.m
//  BigBurger
//
//  Created by Stéphano TELOLAHY on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import "ProductRowTableViewCell.h"

@implementation ProductRowTableViewCell
{
    Product *_product;
    __weak IBOutlet UILabel *_quantityLabel;
    __weak IBOutlet UILabel *_titleLabel;
    __weak IBOutlet UIButton *_decrementButton;
}

#pragma mark - Update

- (void)updateWithProductRow:(ProductRow *)productRow
{
    _product = productRow.product;
    
    _titleLabel.text = productRow.product.title;
    _quantityLabel.text =  [NSString stringWithFormat:@"%d", (int)productRow.quantity] ;
    _decrementButton.hidden = productRow.quantity <= 1;
}

#pragma mark - IBAction

- (IBAction)decrementButtonTouchUpInside:(id)sender
{
    [self.delegate productRowTableViewCell:self didDecrement:_product];
}

- (IBAction)incrementButtonTouchUpInside:(id)sender
{
    [self.delegate productRowTableViewCell:self didIncrement:_product];
}

- (IBAction)deleteButtonTouchUpInside:(id)sender
{
    [self.delegate productRowTableViewCell:self didDelete:_product];
}

@end
