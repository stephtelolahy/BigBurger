//
//  Product.h
//  BigBurger
//
//  Created by Telolahy on 23/02/17.
//  Copyright © 2017 Telolahy. All rights reserved.
//

#import <Foundation/Foundation.h>

// Model for food menu, having the same structure as API response
@interface Product : NSObject

@property   (strong, readonly)  NSString *ref;
@property   (strong, readonly)  NSString *title;
@property   (strong, readonly)  NSString *productDescription;
@property   (strong, readonly)  NSString *thumbnail;
@property   (assign, readonly)  long price;

// Creating instance from JSON object
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
