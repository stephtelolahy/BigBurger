//
//  ProductRowTableViewCell.h
//  BigBurger
//
//  Created by Stéphano TELOLAHY on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductRow.h"

#define ProductRowTableViewCellReuseIdentifier @"ProductRowTableViewCell"

@protocol ProductRowTableViewCellDelegate;

@interface ProductRowTableViewCell : UITableViewCell

@property   (weak, nonatomic) id<ProductRowTableViewCellDelegate> delegate;

- (void)updateWithProductRow:(ProductRow *)productRow;

@end

@protocol ProductRowTableViewCellDelegate <NSObject>

- (void)productRowTableViewCell:(ProductRowTableViewCell *)cell didIncrement:(Product *)product;
- (void)productRowTableViewCell:(ProductRowTableViewCell *)cell didDecrement:(Product *)product;
- (void)productRowTableViewCell:(ProductRowTableViewCell *)cell didDelete:(Product *)product;;

@end
