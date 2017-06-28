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
    return 2;
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
    
    UIView *herbView = _presenting ? toView : fromView;
    CGRect initialFrame = _presenting ? _originFrame : herbView.frame;
    CGRect finalFrame = _presenting ? herbView.frame : _originFrame;
    CGFloat xScaleFactor = _presenting ? initialFrame.size.width / finalFrame.size.width : finalFrame.size.width / initialFrame.size.width;
    CGFloat yScaleFactor = _presenting ? initialFrame.size.height / finalFrame.size.height : finalFrame.size.height / initialFrame.size.height;
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor);
    if (_presenting) {
        herbView.transform = scaleTransform;
        herbView.center = CGPointMake(initialFrame.origin.x + initialFrame.size.width  / 2,initialFrame.origin.y + initialFrame.size.height / 2);
        herbView.clipsToBounds = YES;
        herbView.layer.cornerRadius = 20 / xScaleFactor;
    }
    [containerView addSubview:toView];
    [containerView bringSubviewToFront:herbView];
    
    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        herbView.transform = _presenting ? CGAffineTransformIdentity : scaleTransform;
        herbView.center = CGPointMake(finalFrame.origin.x + finalFrame.size.width / 2, finalFrame.origin.y +finalFrame.size.height / 2);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        if (!_presenting) {
            if (self.dismissCompletionBlock) {
                self.dismissCompletionBlock();
            }
        }
    }];
    [self roundCornersWithLayer:herbView.layer toRadius:_presenting ? 0 : 20 / xScaleFactor withDuration:1];
    
}

- (void)roundCornersWithLayer:(CALayer *) layer toRadius:(CGFloat) radius withDuration:(CGFloat) duration{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = @(layer.cornerRadius);
    animation.toValue = @(radius);
    [layer addAnimation:animation forKey:@"setCornerRadius:"];
    layer.cornerRadius = radius;
}

@end
