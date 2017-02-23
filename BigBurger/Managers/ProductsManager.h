//
//  ProductsManager.h
//  BigBurger
//
//  Created by Telolahy on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@protocol ProductsManagerDelegate;

// Business layer object for fetching products
// First get products from API
// Could be used further to load products from local storage
@interface ProductsManager : NSObject

@property   (weak, nonatomic)   id<ProductsManagerDelegate> delegate;

- (void)fetchProducts;

@end

@protocol ProductsManagerDelegate <NSObject>

- (void)productsManager:(ProductsManager *)manager didSucceed:(NSArray *)products;
- (void)productsManager:(ProductsManager *)manager didFail:(NSError *)error;

@end
