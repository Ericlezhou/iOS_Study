//
//  ViewController.m
//  ImageConerTest
//
//  Created by Eric on 16/3/3.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+CornerImageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //通过贝塞尔曲线绘制圆角
    UIImageView *myImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 180, 180)];
    [myImg setImage:[UIImage imageNamed:@"test.png"]];
    [myImg kt_addConer:10.0];
    [self.view addSubview:myImg];
    //使用系统api直接设置
    UIImageView *youImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 220, 180, 180)];
    [youImg setImage:[UIImage imageNamed:@"test.png"]];
    youImg.layer.cornerRadius = 10;
    [youImg.layer setMasksToBounds:YES];  //针对uilabel这种内部还有子视图的控件
    [self.view addSubview:youImg];
    //使用一张mask图来控制图片的形状。
    UIImageView *hisImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 420, 180, 180)];
    [hisImg setImage:[UIImage imageNamed:@"test.png"]];
    CALayer *layer = [CALayer layer];
    layer.frame = hisImg.bounds;
    layer.contents = (id)[[UIImage imageNamed:@"mask.png"] CGImage];
    [hisImg.layer setMask:layer];
    hisImg.layer.masksToBounds = YES;
    hisImg.layer.borderColor = [UIColor clearColor].CGColor;
    hisImg.layer.magnificationFilter = kCAFilterNearest;
    hisImg.layer.shouldRasterize = YES;
    [self.view addSubview:hisImg];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
