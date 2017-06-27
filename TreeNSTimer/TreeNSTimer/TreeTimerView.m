//
//  TreeTimerView.m
//  TreeNSTimer
//
//  Created by Eric on 2017/6/14.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import "TreeTimerView.h"

@implementation TreeTimerView

- (void)testDeallocTimer{
    self.strongTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(printTestStrongTimer) userInfo:nil repeats:YES];
    [self.strongTimer fire];
}

- (void)printTestStrongTimer{
    static int count = 0;
    NSLog(@"printTestStrongTimer %d",count++);
}

@end
