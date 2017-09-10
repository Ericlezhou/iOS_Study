//
//  LRPresentAnimator.m
//  LRAnimation
//
//  Created by le zhou on 2017/9/3.
//  Copyright © 2017年 le zhou. All rights reserved.
//

#import "LRPresentAnimator.h"
#import "UIView+ShortCut.h"


@implementation LRPresentAnimator
- (instancetype)init {
    if (self = [super init]) {
        _isPresenting = YES;
    }
    return self;
}

// This is used for percent driven interactive transitions, as well as for
// container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    CGRect beforeAnimateViewRect = CGRectZero;
    CGRect afterAnimateViewRect = CGRectZero;
    UIView *beforeAnimateView = nil;
    UIView *afterAnimateView = nil;
    UIView *containerView = transitionContext.containerView;
    
    UIViewController *beforeAnimateVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if ([beforeAnimateVC isKindOfClass:[UINavigationController class]]) {
        beforeAnimateVC = [((UINavigationController *)beforeAnimateVC) topViewController];
    }
    if (beforeAnimateVC && [beforeAnimateVC respondsToSelector:@selector(popOriginRectForLRPresentAnimator:)]) {
        beforeAnimateViewRect = [((id<LRPresentAnimatorHelperProtocol>)beforeAnimateVC) popOriginRectForLRPresentAnimator:self];
    }
    
    UIViewController *afterAnimateVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if ([afterAnimateVC isKindOfClass:[UINavigationController class]]) {
        afterAnimateVC = [((UINavigationController *)afterAnimateVC) topViewController];
    }
    if (afterAnimateVC && [afterAnimateVC respondsToSelector:@selector(popOriginRectForLRPresentAnimator:)]) {
        afterAnimateViewRect = [((id<LRPresentAnimatorHelperProtocol>)afterAnimateVC) popOriginRectForLRPresentAnimator:self];
    }
    
    beforeAnimateView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    afterAnimateView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    //如果是present，transition动画使用的是toView； 如果是dimiss，transition使用的是fromView，但终究使用的都是被present出去的那个controller
    UIView *showView = _isPresenting ? afterAnimateView : beforeAnimateView;
    UIView *backgroudView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backgroudView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:backgroudView];
    [containerView addSubview:showView];
    
    CGRect tinyImageRect = _isPresenting ? beforeAnimateViewRect : afterAnimateViewRect;
    CGRect fullImageRect = _isPresenting ? afterAnimateViewRect : beforeAnimateViewRect;
    
    CGFloat xScaleFactor = tinyImageRect.size.width / fullImageRect.size.width;
    CGFloat yScaleFactor = tinyImageRect.size.height / fullImageRect.size.height;
    //缩小的后的比例
    CGAffineTransform customTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor);
    
    if (_isPresenting) {
        //由小变大
        //首帧需要和present之前的保持一致，故先缩小比例，变为预览图大小
        showView.transform = customTransform;
        showView.center = CGPointMake(CGRectGetMidX(tinyImageRect), CGRectGetMidY(tinyImageRect));
    }else{
        //由大变小
        //比例不需要改变
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        if (_isPresenting) {
            //动画渐变为原始的全屏大小的比例
            showView.transform = CGAffineTransformIdentity;
            showView.center = CGPointMake(CGRectGetMidX(fullImageRect), CGRectGetMidY(fullImageRect));
        }else{
            //动画渐变为预览图大小的比例
            showView.transform = customTransform;
            showView.center = CGPointMake(CGRectGetMidX(tinyImageRect), CGRectGetMidY(tinyImageRect));
        }
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    
}
@end











