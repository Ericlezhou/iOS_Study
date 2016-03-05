//
//  UIImage+CornerImage.m
//  CornerRadius
//
//  Created by 周乐 on 16/3/3.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "UIImage+CornerImage.h"

@implementation UIImage (CornerImage)

-(UIImage *)kt_drawRectWithRoundedCornerWithRadius:(CGFloat)radius withSize:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    [self drawInRect:rect];
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathStroke);
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return output;
    
}
@end
