//
//  OrderEntry.m
//  MRRDemo
//
//  Created by Eric on 2017/5/3.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import "OrderEntry.h"

@implementation OrderEntry
- (id) initWithId:(NSString *)oid{
    if (self = [super init]) {
        NSLog(@"Initializing OrderEntry object");
        orderId = oid;
        [orderId retain];
        item = [[OrderItem alloc] initWithName:@"Doodle"];
        shippingAddress = [[Address alloc] init];
    }
    return self;
}

-(void)dealloc{
    NSLog(@"Deallocating OrderEntry object");
    [item release];
    [orderId release];
    [shippingAddress release];
    [super dealloc];
}
@end
