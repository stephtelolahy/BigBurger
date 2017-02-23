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
    __weak typeof(self) weakSelf = self;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"https://bigburger.useradgents.com/catalog"]
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil)
        {
            // model parsing in background thread
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSMutableArray *products = [[NSMutableArray alloc] init];
            for (NSDictionary* dictionary in jsonArray) {
                [products addObject:[[Product alloc] initWithDictionary:dictionary]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.delegate productsManager:weakSelf didSucceed:products];
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.delegate productsManager:weakSelf didFail:error];
            });
        }
    }];
    
    [dataTask resume];
}

@end
