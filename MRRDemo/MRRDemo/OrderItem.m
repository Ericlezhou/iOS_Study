//
//  OrderItem.m
//  MRRDemo
//
//  Created by Eric on 2017/5/3.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import "OrderItem.h"

@implementation OrderItem
- (id) initWithName:(NSString *)itemName{
    if (self = [super init]) {
        NSLog(@"Initializing OrderItem object");
        name = itemName;
        [name retain];
    }
    return self;
}

-(void)dealloc{
    NSLog(@"Deallocating OrderItem object");
    [name release];
    [super dealloc];
}
@end
