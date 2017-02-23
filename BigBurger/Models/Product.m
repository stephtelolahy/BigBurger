//
//  Product.m
//  BigBurger
//
//  Created by Telolahy on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import "Product.h"

@implementation Product

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSParameterAssert(dictionary);
    
    self = [super init];
    if (self != nil) {
        _ref = [dictionary objectForKey:@"ref"];
        _title = [dictionary objectForKey:@"title"];
        _productDescription = [dictionary objectForKey:@"description"];
        _thumbnail = [dictionary objectForKey:@"thumbnail"];
        _price = [[dictionary objectForKey:@"price"] doubleValue] * 0.01f;
    }
    return self;
}

@end
