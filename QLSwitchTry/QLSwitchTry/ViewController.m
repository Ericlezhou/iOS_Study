//
//  ViewController.m
//  QLSwitchTry
//
//  Created by Eric on 16/8/5.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    UISwitch *usw = [[UISwitch alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    usw.onTintColor = [UIColor colorWithRed:255.0/255 green:141.0/255 blue:51.0/255 alpha:1];
    usw.transform = CGAffineTransformMakeScale(0.7843, 0.7843);
    
    
    
    [self.view addSubview:usw];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
