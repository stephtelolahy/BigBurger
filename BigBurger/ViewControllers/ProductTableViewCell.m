//
//  ProductTableViewCell.m
//  BigBurger
//
//  Created by Stéphano TELOLAHY on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import "ProductTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ProductTableViewCell
{
    Product *_product;
    __weak IBOutlet UIImageView *_productImageview;
    __weak IBOutlet UILabel *_productTitle;
    __weak IBOutlet UILabel *_productDescription;
    __weak IBOutlet UIButton *_productAddButton;
}

#pragma mark - Update

- (void)updateWithProduct:(Product *)product
{
    NSParameterAssert(product);
    
    _product = product;
    
    _productTitle.text = product.title;
    _productDescription.text = product.productDescription;
    [_productImageview sd_setImageWithURL:[NSURL URLWithString:product.thumbnail]];
    [_productAddButton setTitle:[NSString stringWithFormat:@"+ %.2f €", ((float)product.price) * 0.01f] forState:UIControlStateNormal];
}

#pragma mark - IBAction

- (IBAction)addTouchUpInside:(id)sender
{
    [self.delegate productTableViewCell:self didAddProduct:_product];
}

@end
