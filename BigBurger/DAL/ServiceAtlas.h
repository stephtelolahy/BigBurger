//
//  ServiceAtlas.h
//  BigBurger
//
//  Created by Stéphano TELOLAHY on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import <Foundation/Foundation.h>


// Each API call is defined by a Service
// Here are defined all request configuration for available services
@interface ServiceAtlas : NSObject

typedef NS_ENUM(NSInteger, ServiceType){
    ServiceTypeGetProducts
};

// Get url for given service
+ (NSString *)urlForService:(ServiceType)servicetype;

// Parse model for given service
+ (id)parseModelForService:(ServiceType)servicetype data:(NSData *)data;

@end
