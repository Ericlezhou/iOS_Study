//
//  ViewController.m
//  GifSupport
//
//  Created by Eric on 2016/12/27.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(!_imageView){
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, 400, 400)];
        [self.view addSubview:_imageView];
    }
    NSString *filePath = [NSString stringWithFormat:@"%@/1234.gif",[[NSBundle mainBundle] resourcePath]];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:filePath];
    [_imageView setImage:image];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
