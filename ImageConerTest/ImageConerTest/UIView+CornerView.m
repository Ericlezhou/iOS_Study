//
//  UIView+CornerView.m
//  CornerRadius
//
//  Created by 周乐 on 16/3/2.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "UIView+CornerView.h"

@implementation UIView (CornerView)

-(double) pixel:(double) num{
    double unit;
    switch ((int)[UIScreen mainScreen].scale) {
        case 1:
            unit = 1.0 / 1.0;
            break;
        case 2:
            unit = 1.0 / 2/0;
            break;
        case 3:
            unit = 1.0 / 3.0;
            break;
        default:
            unit = 0.0;
            break;
    }
    double remain = modf(num, &unit);
    if (remain > unit / 2.0) {
        return num - modf(num, &unit) +unit;
    }else{
        return num -modf(num, &unit);
    }
    return 0;
}


-(UIView *)kt_addConer:(CGFloat)radius{
    UIImageView *img = [[UIImageView alloc] initWithImage:[self kt_drawRectWithRoundedCornerWithRadius:radius bordWidth:1 backgroundColor:[UIColor clearColor] borderColor:[UIColor blackColor]]];
    [self addSubview:img];
    return self;
}

-(UIImage *)kt_drawRectWithRoundedCornerWithRadius:(CGFloat)radius bordWidth:(CGFloat)bordWidth backgroundColor:(UIColor *)bgColor borderColor:(UIColor *)bdColor{
    
    CGSize sizeToFit = CGSizeMake([self pixel:self.bounds.size.width], self.bounds.size.height);
    CGFloat halfBorderWidth = bordWidth / 2;
    
    UIGraphicsBeginImageContextWithOptions(sizeToFit, false, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, bordWidth);
    CGContextSetStrokeColorWithColor(context, bdColor.CGColor);
    CGContextSetFillColorWithColor(context, bgColor.CGColor);
    
    CGFloat width = sizeToFit.width;
    CGFloat height = sizeToFit.height;
    CGContextMoveToPoint(context, width - halfBorderWidth, radius + halfBorderWidth);  // 开始坐标右边开始
    CGContextAddArcToPoint(context, width - halfBorderWidth, height - halfBorderWidth, width - radius - halfBorderWidth, height - halfBorderWidth, radius);  // 右下角角度
    CGContextAddArcToPoint(context, halfBorderWidth, height - halfBorderWidth, halfBorderWidth, height - radius - halfBorderWidth, radius); // 左下角角度
    CGContextAddArcToPoint(context, halfBorderWidth, halfBorderWidth, width - halfBorderWidth, halfBorderWidth, radius); // 左上角
    CGContextAddArcToPoint(context, width - halfBorderWidth, halfBorderWidth, width - halfBorderWidth, radius + halfBorderWidth, radius); // 右上角
    
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathStroke);
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  result;
}

@end

































