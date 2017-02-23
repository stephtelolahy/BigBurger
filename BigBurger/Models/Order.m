//
//  Order.m
//  BigBurger
//
//  Created by Telolahy on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import "Order.h"

@implementation Order

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        _productRows = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Public methods

- (NSInteger)totalQuantity
{
    NSInteger result  = 0;
    for (ProductRow *row in _productRows)
    {
        result+= row.quantity;
    }
    return result;
}

- (double)totalPrice
{
    double result = 0;
    for (ProductRow *row in _productRows)
    {
        result+= row.product.price * row.quantity;
    }
    return result;
}

- (void)incrementProduct:(Product *)product
{
    ProductRow *row = [self rowForProduct:product];
    if (!row)
    {
        row = [self addRowForProduct:product];
    }
    row.quantity++;
}

- (void)decrementProduct:(Product *)product
{
    ProductRow *row = [self rowForProduct:product];
    if (row)
    {
        if (row.quantity > 1)
        {
            row.quantity--;
        }
        else
        {
            [_productRows removeObject:row];
        }
    }
}

- (void)removeProductRow:(Product *)product
{
    ProductRow *row = [self rowForProduct:product];
    if (row)
    {
        [_productRows removeObject:row];
    }
}

#pragma mark - Private methods

- (ProductRow *)rowForProduct:(Product *)product
{
    for (ProductRow *row in _productRows)
    {
        if ([row.product.ref isEqualToString:product.ref])
        {
            return row;
        }
    }
    return nil;
}

- (ProductRow *)addRowForProduct:(Product *)product
{
    ProductRow *row = [[ProductRow alloc] init];
    row.product = product;
    row.quantity = 0;
    [_productRows addObject:row];
    return row;
}

@end
