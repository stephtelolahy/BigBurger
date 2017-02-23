//
//  NetworkOperation.h
//  BigBurger
//
//  Created by Stéphano TELOLAHY on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceAtlas.h"

@protocol NetworkOperationDelegate;

// A pattern-command NSOperation for API call
// See ServiceAtlas for configuration
@interface NetworkOperation : NSOperation

+ (NSOperationQueue *)sharedQueue;

@property   (weak, nonatomic) id<NetworkOperationDelegate> delegate;

- (instancetype)initWithServiceType:(ServiceType)serviceType;

@end


@protocol NetworkOperationDelegate <NSObject>

- (void)networkOperation:(NetworkOperation *)operation didSucceed:(id)model;
- (void)networkOperation:(NetworkOperation *)operation didFail:(NSError *)error;

@end
