//
//  ProductRow.h
//  BigBurger
//
//  Created by Stéphano TELOLAHY on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface ProductRow : NSObject

@property   (strong, nonatomic) Product *product;
@property   (assign, nonatomic) NSInteger quantity;

@end
