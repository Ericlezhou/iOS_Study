//
//  Atom.m
//  MessageForward
//
//  Created by Eric on 2017/4/17.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import "Atom.h"

@implementation Atom

- (instancetype)init
{
    if (self = [super init])
    {
        _chemicalElement = @"None";
    }
    return self;
}

- (NSUInteger) massNumber
{
    return self.neutrons + self.protons;
}

#pragma mark - write delegaet
-(void)write:(NSFileHandle *)file
{
    NSData *data = [self.chemicalElement dataUsingEncoding:NSUTF8StringEncoding];
    [file writeData:data];
    [file closeFile];
}
@end
