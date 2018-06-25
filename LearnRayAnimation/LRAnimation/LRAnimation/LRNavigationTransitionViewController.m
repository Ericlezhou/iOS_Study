//
//  LRNavigationTransitionViewController.m
//  LRAnimation
//
//  Created by Eric on 2018/2/8.
//  Copyright © 2018年 le zhou. All rights reserved.
//

#import "LRNavigationTransitionViewController.h"
#import "LRTargetNavigationTransitionViewController.h"
#import "RevealAnimator.h"

@interface LRNavigationTransitionViewController () <UINavigationControllerDelegate>
@property (nonatomic, strong) RevealAnimator *transition;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation LRNavigationTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.transition = [RevealAnimator new];
    _imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked:)];
    [_imageView addGestureRecognizer:tapG];
    self.navigationController.delegate = self;
}

- (void)imageClicked:(id)sender {
    LRTargetNavigationTransitionViewController *viewCtl = [[LRTargetNavigationTransitionViewController alloc] initWithNibName:nil bundle:nil];
    viewCtl.imagName = @"IMG_0294.png";
    [self.navigationController pushViewController:viewCtl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    _transition.operation = operation;
    return _transition;
}

@end
