//
//  ViewController.m
//  TreeNSTimer
//
//  Created by Eric on 2017/6/14.
//  Copyright © 2017年 Eric. All rights reserved.
//
#import "ViewController.h"
#import "ViewController+AssociatedObjects.h"
#import "DetailViewController.h"
#import "PopAnimator.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *presentImgeView;
@property (nonatomic, strong) PopAnimator *transition;
@end

__weak NSString *string_weak_assign = nil;
__weak NSString *string_weak_retain = nil;
__weak NSString *string_weak_copy   = nil;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.associatedObject_assign = [NSString stringWithFormat:@"leichunfeng1"];
    self.associatedObject_retain = [NSString stringWithFormat:@"leichunfeng2"];
    self.associatedObject_copy   = [NSString stringWithFormat:@"leichunfeng3"];
    
    string_weak_assign = self.associatedObject_assign;
    string_weak_retain = self.associatedObject_retain;
    string_weak_copy   = self.associatedObject_copy;
    
    [self.presentImgeView setImage:[UIImage imageNamed:@"img"]];
    self.presentImgeView.userInteractionEnabled = YES;
    self.presentImgeView.layer.cornerRadius = 20;
    self.presentImgeView.clipsToBounds = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toucheImage:)];
    [self.presentImgeView addGestureRecognizer:gesture];
    if (!self.transition) {
        self.transition = [[PopAnimator alloc] init];
        __weak typeof(self) weakSelf = self;
        self.transition.dismissCompletionBlock = ^{
            weakSelf.presentImgeView.hidden = NO;
        };
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toucheImage:(id)sender {
    //    NSLog(@"self.associatedObject_assign: %@", self.associatedObject_assign); // Will Crash
    NSLog(@"self.associatedObject_retain: %@", self.associatedObject_retain);
    NSLog(@"self.associatedObject_copy:   %@", self.associatedObject_copy);
    DetailViewController *dvc = [[DetailViewController alloc] init];
    dvc.transitioningDelegate = self;
    [self presentViewController:dvc animated:YES completion:nil];
}

#pragma UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    self.transition.presenting = YES;
    self.transition.originFrame = self.presentImgeView.frame;
    self.presentImgeView.hidden = YES;
    return self.transition;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    self.transition.presenting = NO;
    return self.transition;
}
@end
