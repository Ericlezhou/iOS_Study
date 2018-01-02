//
//  UIView+additions.m
//  CustomTableViewHeader
//
//  Created by Eric on 2017/12/29.
//  Copyright © 2017年 nexus. All rights reserved.
//

#import "UIView+additions.h"

@implementation UIView (additions)
- (void)removeAllSubviews{
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }
}
@end
