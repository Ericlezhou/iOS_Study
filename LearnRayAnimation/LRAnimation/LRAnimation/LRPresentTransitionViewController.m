//
//  LRPresentTransitionViewController.m
//  LRAnimation
//
//  Created by le zhou on 2017/9/3.
//  Copyright © 2017年 le zhou. All rights reserved.
//

#import "LRPresentTransitionViewController.h"

@interface LRPresentTransitionViewController ()
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LRPresentTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_0294.png"]];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    CGFloat imageW = 150;
    CGFloat imageH = 200;
    _imageView.frame = CGRectMake(0, 0, imageW, imageH);
    _imageView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetHeight(self.view.bounds) - imageH * 0.5);
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
    UITapGestureRecognizer *tapGe = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
    [_imageView addGestureRecognizer:tapGe];
}

- (void)imageTapped:(id)sender{
    NSLog(@"");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
