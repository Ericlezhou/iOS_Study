//
//  ViewController.m
//  GlassEffectView
//
//  Created by Eric on 2017/12/4.
//  Copyright © 2017年 nexus. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"iPhone X.png"];
    self.imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit | UIViewContentModeTop;
    [self.view addSubview:self.imageView];
    self.imageView.frame = self.view.bounds;
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:self.imageView.bounds];
    // 改变barStyle可以显示不同样式的高斯模糊
    toolBar.barStyle = UIBarStyleBlack;
    toolBar.backgroundColor = [UIColor colorWithWhite:0 alpha:0.74f];
    [self.view addSubview:toolBar];
}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
