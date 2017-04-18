//
//  Hydrogen.m
//  MessageForward
//
//  Created by Eric on 2017/4/17.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import "Hydrogen.h"
#import "HydrogenHelper.h"
#import <objc/runtime.h>
#import "AtomProxy.h"

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

//add instance method
void bombIMP(id self, SEL _cmd)
{
    NSLog(@"It may be the source of bomb!!! (bombIMP called)");
}

+(BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(bomb))
    {
        class_addMethod([self class], sel, (IMP)bombIMP, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

//add class method
void classBombIMP(id self, SEL _cmd)
{
    NSLog(@"It may be really the source of bomb!!! (classBombIMP called)");
}

+(BOOL)resolveClassMethod:(SEL)sel
{
    if (sel == @selector(classBomb))
    {
        Class class = object_getClass(NSClassFromString(@"Hydrogen"));      //right
//        Class class1 = [self superclass];                                 //wrong, cause Hydrogen's superclass is Atom, but not the isa pointer.
        class_addMethod(class, sel, (IMP)classBombIMP, "v@:");
        return YES;
    }
    return [super resolveClassMethod:sel];
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
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return [AtomProxy instanceMethodSignatureForSelector:aSelector];
}

-(void)forwardInvocation:(NSInvocation *)anInvocation
{
    AtomProxy *proxy = [AtomProxy new];
    proxy.innerValue = @"invocation test";
    [anInvocation invokeWithTarget:proxy];
}
@end
