//
//  RevealAnimator.h
//  LRAnimation
//
//  Created by Eric on 2018/2/8.
//  Copyright © 2018年 le zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RevealAnimator : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, assign) UINavigationControllerOperation operation;
@end
