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

@property   (strong, nonatomic, readonly) NSMutableArray *productRows;
@property   (assign, readonly)  double totalPrice;

// increment productrow quantity
- (void)incrementProduct:(Product *)product;

// decrement productrow quantity
- (void)decrementProduct:(Product *)product;

// Remove an entire product row
- (void)removeProductRow:(Product *)product;

@end
