//
//  ProductsManager.m
//  BigBurger
//
//  Created by Telolahy on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import "ProductsManager.h"

@implementation ProductsManager

- (void)fetchProducts
{
    // TODO implement NSURLSession
    
    [self.delegate productsManager:self didSucceed:@[]];
}

@end
