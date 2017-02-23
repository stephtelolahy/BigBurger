//
//  ProductRowTableViewCell.m
//  BigBurger
//
//  Created by Stéphano TELOLAHY on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import "ProductRowTableViewCell.h"

@implementation ProductRowTableViewCell

- (void)updateWithProductRow:(ProductRow *)productRow
{
    self.textLabel.text = [NSString stringWithFormat:@"%dx%@", (int)productRow.quantity, productRow.product.title];
}

@end
