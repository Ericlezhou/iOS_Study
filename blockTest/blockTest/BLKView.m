//
//  BLKView.m
//  blockTest
//
//  Created by Eric on 16/2/28.
//  Copyright © 2016年 ericlezhou. All rights reserved.
//

#import "BLKView.h"

@interface BLKView()

@property (nonatomic, copy) FeedbackBlock block;

@end

@implementation BLKView

-(instancetype)initWithFBBlcok:(FeedbackBlock)inBlock{
    if (self = [super init]) {
        self.block = inBlock;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"hello" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(160, 160, 80, 40);
        button.backgroundColor = [UIColor yellowColor];
        [button addTarget:self action:@selector(hello) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
    }
    return self;
}

-(void)hello{
    if (self.block) {
        self.block(@"byebye");
    }
}

-(void)dealloc{
    NSLog(@"blkview is dealloc");
}
@end
