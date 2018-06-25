//
//  RevealAnimator.m
//  LRAnimation
//
//  Created by Eric on 2018/2/8.
//  Copyright © 2018年 le zhou. All rights reserved.
//

#import "RevealAnimator.h"
@interface RevealAnimator ()
@end

@implementation RevealAnimator

- (instancetype)init {
    if (self = [super init]) {
        _animationDuration = 2;
        _operation = UINavigationControllerOperationPush;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return _animationDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
}

@end
