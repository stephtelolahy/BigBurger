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
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"https://bigburger.useradgents.com/catalog"]
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil)
        {
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSMutableArray *products = [[NSMutableArray alloc] init];
            for (NSDictionary* dictionary in jsonArray) {
                [products addObject:[[Product alloc] initWithDictionary:dictionary]];
            }
            [self.delegate productsManager:self didSucceed:products];
        }
        else
        {
            [self.delegate productsManager:self didFail:error];
        }
    }];
    
    [dataTask resume];
}

@end
