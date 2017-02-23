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
    [self rowForProduct:product].quantity++;
}

- (void)decrementProduct:(Product *)product
{
    [self rowForProduct:product].quantity--;
}

- (void)removeProductRow:(Product *)product
{
    ProductRow *rowToDelete = nil;
    for (ProductRow *row in _productRows)
    {
        if ([row.product.ref isEqualToString:product.ref])
        {
            rowToDelete = row;
            break;
        }
    }
    if (rowToDelete)
    {
        [_productRows removeObject:rowToDelete];
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
    // no row found
    ProductRow *row = [[ProductRow alloc] init];
    row.product = product;
    row.quantity = 0;
    [_productRows addObject:row];
    return row;
}

@end
