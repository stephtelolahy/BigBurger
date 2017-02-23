//
//  ServiceAtlas.m
//  BigBurger
//
//  Created by Stéphano TELOLAHY on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import "ServiceAtlas.h"
#import "Product.h"

@implementation ServiceAtlas

+ (NSString *)urlForService:(ServiceType)servicetype
{
    switch (servicetype) {
        case ServiceTypeGetProducts:
            return @"https://bigburger.useradgents.com/catalog";
    }
}

+ (id)parseModelForService:(ServiceType)servicetype data:(NSData *)data
{
    switch (servicetype) {
        case ServiceTypeGetProducts:
        {
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSMutableArray *products = [[NSMutableArray alloc] init];
            for (NSDictionary* dictionary in jsonArray) {
                [products addObject:[[Product alloc] initWithDictionary:dictionary]];
            }
            return products;
        }
    }
}

@end
