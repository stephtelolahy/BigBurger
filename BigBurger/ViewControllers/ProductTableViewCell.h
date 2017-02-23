//
//  ProductTableViewCell.h
//  BigBurger
//
//  Created by Stéphano TELOLAHY on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

#define ProductTableViewCellReuseIdetifier @"ProductTableViewCell"

@protocol ProductTableViewCellDelegate;

@interface ProductTableViewCell : UITableViewCell

@property   (weak, nonatomic) id<ProductTableViewCellDelegate> delegate;

- (void)updateWithProduct:(Product *)product;

@end

@protocol ProductTableViewCellDelegate <NSObject>

- (void)productTableViewCell:(ProductTableViewCell *)cell didAddProduct:(Product *)product;

@end
