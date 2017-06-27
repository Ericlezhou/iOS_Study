//
//  PopAnimator.h
//  TreeNSTimer
//
//  Created by Eric on 2017/6/27.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PopAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL presenting;
@property (nonatomic, assign) CGRect originFrame;

@end
