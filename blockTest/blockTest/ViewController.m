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
    startBtn.frame = CGRectMake(140, 140, 80, 20);
    [startBtn setTitle:@"CLICK" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    startBtn.backgroundColor = [UIColor redColor];
    [startBtn addTarget:self action:@selector(jumpT) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    self.button = startBtn;
    self.title = @"ViewController";
}

- (void)jumpT{
    
    //这里ViewController的vc属性 强引用了 BLKViewController实例 强引用了 BLKBlock实例 强引用了 ViewController，构成了一个环，即出现了block中的循环引用，这时候应该使用__weak __typeof(self) weakself = self  或者不声明vc属性。
    __weak __typeof(self) weakself = self;
    BLKViewController *vtc = [[BLKViewController alloc] initWithCallBackBlcok:^{
        [weakself.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }];
//    self.vc = vtc;
    [self.navigationController pushViewController:vtc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
