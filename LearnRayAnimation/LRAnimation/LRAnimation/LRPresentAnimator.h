//
//  LRPresentAnimator.h
//  LRAnimation
//
//  Created by le zhou on 2017/9/3.
//  Copyright © 2017年 le zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class LRPresentAnimator;

@protocol LRPresentAnimatorHelperProtocol
@optional
- (CGRect)popOriginRectForLRPresentAnimator:(LRPresentAnimator *)presentAnimator;
@end

@interface LRPresentAnimator : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) BOOL isPresenting;
@end
