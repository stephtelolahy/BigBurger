//
//  Order.h
//  BigBurger
//
//  Created by Telolahy on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductRow.h"

// Model for an order
@interface Order : NSObject

// Array of product rows
@property   (strong, nonatomic, readonly) NSMutableArray *productRows;

// Sum of product rows quantity
@property   (assign, readonly)  NSInteger totalQuantity;

// Sum of product rows price
@property   (assign, readonly)  double totalPrice;

// increment productrow quantity
- (void)incrementProduct:(Product *)product;

// decrement productrow quantity
- (void)decrementProduct:(Product *)product;

// Remove an entire product row
- (void)removeProductRow:(Product *)product;

@end
