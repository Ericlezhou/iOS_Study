//
//  LRTargetPresentViewController.m
//  LRAnimation
//
//  Created by le zhou on 2017/9/3.
//  Copyright © 2017年 le zhou. All rights reserved.
//

#import "LRTargetPresentViewController.h"
#import "LRPresentAnimator.h"

@interface LRTargetPresentViewController ()<LRPresentAnimatorHelperProtocol>
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation LRTargetPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    if (self.imagName.length) {
        [_imageView setImage:[UIImage imageNamed:self.imagName]];
    }
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAction:)];
    [_imageView addGestureRecognizer:tapRec];
}

- (void)dismissAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - LRPresentAnimatorHelperProtocol
- (CGRect)popOriginRectForLRPresentAnimator:(LRPresentAnimator *)presentAnimator {
    return self.imageView.frame;
}

@end
