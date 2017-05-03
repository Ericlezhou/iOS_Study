//
//  OrderEntry.h
//  MRRDemo
//
//  Created by Eric on 2017/5/3.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderItem.h" 
#import "Address.h"
@interface OrderEntry : NSObject
{
    @public OrderItem *item;
    NSString *orderId;
    Address *shippingAddress;
}

- (id) initWithId:(NSString *)oid;
@end
