//
//  Atom.h
//  MessageForward
//
//  Created by Eric on 2017/4/17.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Writer.h"

@interface Atom : NSObject <Writer>
{
    @protected NSUInteger _protons;
    @protected NSUInteger _neutrons;
    @protected NSUInteger _electrons;
    @protected NSString *_chemicalElement;
    @protected NSString *_atomicSymbol;
}

@property (readonly) NSUInteger protons; //质子
@property (readonly) NSUInteger neutrons; //中子
@property (readonly) NSUInteger electrons; //电子
@property (readonly) NSString *chemicalElement;
@property (readonly) NSString *atomicSymbol;

- (NSUInteger) massNumber;
@end
