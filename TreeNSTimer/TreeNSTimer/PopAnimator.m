//
//  PopAnimator.m
//  TreeNSTimer
//
//  Created by Eric on 2017/6/27.
//  Copyright © 2017年 Eric. All rights reserved.
//
#import "PopAnimator.h"

@interface PopAnimator() 

@end

@implementation PopAnimator

- (instancetype)init{
    if (self = [super init]) {
        _presenting = YES;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *fromView, *toView;
    UIView *containerView = [transitionContext containerView];
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }else{
        fromView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
        toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    }
    CGRect initialFrame = _presenting ? _originFrame : toView.frame;
    CGRect finalFrame = _presenting ? toView.frame : _originFrame;
    CGFloat xScaleFactor = _presenting ? initialFrame.size.width / finalFrame.size.width : finalFrame.size.width / initialFrame.size.width;
    CGFloat yScaleFactor = _presenting ? initialFrame.size.height / finalFrame.size.height : finalFrame.size.height / initialFrame.size.height;
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor);
    [containerView addSubview:toView];
    toView.alpha = 0;
    
}

@end
