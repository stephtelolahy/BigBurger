//
//  ProductsManager.m
//  BigBurger
//
//  Created by Telolahy on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import "ProductsManager.h"
#import "NetworkOperation.h"

@interface ProductsManager()<NetworkOperationDelegate>

@end

@implementation ProductsManager
{
    NetworkOperation *_networkOperation;
}

- (void)fetchProducts
{
    _networkOperation = [[NetworkOperation alloc] initWithServiceType:ServiceTypeGetProducts];
    _networkOperation.delegate = self;
    [[NetworkOperation sharedQueue] addOperation:_networkOperation];
}

#pragma mark - NetworkOperationDelegate

- (void)networkOperation:(NetworkOperation *)operation didSucceed:(id)model
{
    [self.delegate productsManager:self didSucceed:model];
}

- (void)networkOperation:(NetworkOperation *)operation didFail:(NSError *)error
{
    [self.delegate productsManager:self didFail:error];
}


#if 0 // Using NSURLSession

- (void)fetchProducts
{
    __weak typeof(self) weakSelf = self;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"https://bigburger.useradgents.com/catalog"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
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

#endif

@end
