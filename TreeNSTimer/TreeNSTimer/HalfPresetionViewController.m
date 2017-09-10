//
//  HalfPresetionViewController.m
//  TreeNSTimer
//
//  Created by Eric on 2017/7/10.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import "HalfPresetionViewController.h"

@implementation HalfPresetionViewController
- (CGRect)frameOfPresentedViewInContainerView{
    return CGRectMake(0, ceilf(self.containerView.bounds.size.height / 2), self.containerView.bounds.size.width, ceilf(self.containerView.bounds.size.height / 2));
}
@end
