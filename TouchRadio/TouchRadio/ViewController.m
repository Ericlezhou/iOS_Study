//
//  ViewController.m
//  TouchRadio
//
//  Created by Eric on 16/3/15.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "ViewController.h"
#import "SlideButton.h"
@interface ViewController ()
{
    UILabel *_label;
    SlideButton *_slideBtn;
}

@end

@implementation ViewController

-(instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _label = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 166, 40)];
    _slideBtn = [[SlideButton alloc] initWithFrame:CGRectMake(0, 607, self.view.bounds.size.width, 60)];
    _slideBtn.backgroundColor = [UIColor yellowColor];
    _label.hidden = YES;
    _label.backgroundColor = [UIColor redColor];
    _slideBtn.delegate = self;
    [self.view addSubview:_label];
    [self.view addSubview:_slideBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
