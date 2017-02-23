//
//  NetworkOperation.m
//  BigBurger
//
//  Created by Stéphano TELOLAHY on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import "NetworkOperation.h"

@implementation NetworkOperation
{
    ServiceType _serviceType;
}

#pragma mark - Shared queue

+ (NSOperationQueue *)sharedQueue
{
    __strong static NSOperationQueue *_sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[NSOperationQueue alloc] init];
        _sharedObject.maxConcurrentOperationCount = 3;
    });
    return _sharedObject;
}

#pragma mark - Constructor

- (instancetype)initWithServiceType:(ServiceType)serviceType
{
    self = [super init];
    if (self) {
        _serviceType = serviceType;
    }
    return self;
}

#pragma mark - Override

- (void)main
{
    // TODO: use NSURLSession
    
    NSString *stringUrl = [ServiceAtlas urlForService:_serviceType];
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:stringUrl]];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                          returningResponse:&response
                                                      error:&error];
    if (!error)
    {
        id model = [ServiceAtlas parseModelForService:_serviceType data:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate networkOperation:self didSucceed:model];
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate networkOperation:self didFail:error];
        });
    }
}

- (void)cancel
{
    [super cancel];
    self.delegate = nil;
}

@end
