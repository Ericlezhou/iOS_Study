//
//  ViewController.m
//  CopyUseExample
//
//  Created by Eric on 2018/2/11.
//  Copyright © 2018年 nexus. All rights reserved.
//

#import "ViewController.h"
#import "CopyPerson.h"
#import "CopyWorker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CopyPerson *p = [[CopyPerson alloc] init];
    CopyPerson *pp = [p copy];
    
    CopyWorker *w = [[CopyWorker alloc] init];
    CopyWorker *ww = [w copy];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
