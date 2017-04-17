//
//  Hydrogen.m
//  MessageForward
//
//  Created by Eric on 2017/4/17.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import "Hydrogen.h"
#import "HydrogenHelper.h"
@interface Hydrogen()
{
    HydrogenHelper *_helper;
}
@end
@implementation Hydrogen

-(NSString *)chemicalElement
{
    return @"H2";
}

- (instancetype)initWithNeutrons:(NSUInteger) neutrons
{
    if (self = [super init])
    {
        _chemicalElement = @"Hydrogen";
        _atomicSymbol = @"H";
        _protons = 1;
        _neutrons = neutrons;
        _helper = [[HydrogenHelper alloc] init];
    }
    return self;
}

//fast forward
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if (_helper && [_helper respondsToSelector:aSelector])
    {
        return _helper;
    }
    return nil;
}

//normal forward
//-(void)forwardInvocation:(NSInvocation *)anInvocation{}
@end
