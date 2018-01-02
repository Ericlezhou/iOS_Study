//
//  Utils.m
//  CustomTableViewHeader
//
//  Created by Eric on 2017/12/29.
//  Copyright © 2017年 nexus. All rights reserved.
//

#import "Utils.h"

@implementation Utils
+ (CGFloat)getScreenWidth {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    return MIN(width, height);
}

+ (CGFloat)getScreenHeight {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    return MAX(width, height);
}
@end
