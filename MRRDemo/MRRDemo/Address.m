//
//  Address.m
//  MRRDemo
//
//  Created by Eric on 2017/5/3.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import "Address.h"

@implementation Address
- (instancetype) init{
    if (self = [super init]) {
        NSLog(@"Initializing Address object");
    }
    return self;
}

- (void)dealloc{
    NSLog(@"Deallocating Address object");
    [super dealloc];
}

@end
