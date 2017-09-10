//
//  LRPresentTransitionViewController.m
//  LRAnimation
//
//  Created by le zhou on 2017/9/3.
//  Copyright © 2017年 le zhou. All rights reserved.
//

#import "LRPresentTransitionViewController.h"
#import "LRTargetPresentViewController.h"
#import "LRPresentAnimator.h"

@interface LRPresentTransitionViewController ()<LRPresentAnimatorHelperProtocol>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation LRPresentTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked:)];
    [_imageView addGestureRecognizer:tapG];
}

- (void)imageClicked:(id)sender {
    LRTargetPresentViewController *viewCtl = [[LRTargetPresentViewController alloc] initWithNibName:nil bundle:nil];
    viewCtl.imagName = @"IMG_0294.png";
    viewCtl.transitioningDelegate = self;
    [self presentViewController:viewCtl animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    LRPresentAnimator *animator = [[LRPresentAnimator alloc] init];
    animator.isPresenting = YES;
    return animator;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    LRPresentAnimator *animator = [[LRPresentAnimator alloc] init];
    animator.isPresenting = NO;
    return animator;
}

#pragma mark - LRPresentAnimatorHelperProtocol
- (CGRect)popOriginRectForLRPresentAnimator:(LRPresentAnimator *)presentAnimator {
    return self.imageView.frame;
}

@end
