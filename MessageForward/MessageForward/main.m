//
//  main.m
//  MessageForward
//
//  Created by Eric on 2017/4/17.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hydrogen.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        Hydrogen *h = [[Hydrogen alloc] initWithNeutrons:1];
        NSString *str = [h performSelector:@selector(factoid)];
        NSLog(@"%@",str);
    }
    return 0;
}
