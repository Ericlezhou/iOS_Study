//
//  DetailViewControllerV2.m
//  TreeNSTimer
//
//  Created by Eric on 2017/7/10.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import "DetailViewControllerV2.h"

@interface DetailViewControllerV2 ()

@end

@implementation DetailViewControllerV2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height * 0.5, self.view.bounds.size.width, self.view.bounds.size.height * 0.5)];
    view1.backgroundColor = [UIColor redColor];
    view1.userInteractionEnabled = YES;
    [self.view addSubview:view1];
    [view1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchImg:)]];
}

- (void)touchImg:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

@end
