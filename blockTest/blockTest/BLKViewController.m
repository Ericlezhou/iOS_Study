//
//  BLKViewController.m
//  blockTest
//
//  Created by 周乐 on 16/2/28.
//  Copyright © 2016年 ericlezhou. All rights reserved.
//

#import "BLKViewController.h"
@interface BLKViewController()

@property (nonatomic,strong) BLKBlock callbackBlock;

@end

@implementation BLKViewController

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(instancetype)initWithCallBackBlcok:(BLKBlock) inBlcok{
    if (self = [super init]) {
        self.callbackBlock = inBlcok;
    }
    return  self;
}
@end
