//
//  ViewController.m
//  blockTest
//
//  Created by 周乐 on 16/2/27.
//  Copyright © 2016年 ericlezhou. All rights reserved.
//

#import "ViewController.h"
#import "BLKViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) BLKViewController *vc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.frame = CGRectMake(140, 140, 40, 20);
    startBtn.titleLabel.text = @"click";
    startBtn.titleLabel.textColor = [UIColor blueColor];
    startBtn.backgroundColor = [UIColor redColor];
    [startBtn addTarget:self action:@selector(jumpT) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
}

- (void)jumpT{
    BLKViewController *vtc = [[BLKViewController alloc] initWithCallBackBlcok:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
