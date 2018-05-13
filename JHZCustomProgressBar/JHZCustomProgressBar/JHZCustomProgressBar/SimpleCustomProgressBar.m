//
//  SimpleCustomProgressBar.m
//  JHZCustomProgressBar
//
//  Created by Eric on 2018/5/13.
//  Copyright © 2018年 nexus. All rights reserved.
//

#import "SimpleCustomProgressBar.h"

@implementation SimpleCustomProgressBar

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* fillColor = [UIColor colorWithRed: 0.416 green: 0.416 blue: 0.416 alpha: 1];
    UIColor* strokeColor = [UIColor colorWithRed: 0.322 green: 0.322 blue: 0.322 alpha: 1];
    UIColor* shadowColor2 = [UIColor colorWithRed: 0.2 green: 0.2 blue: 0.2 alpha: 1];
    UIColor* shadowColor3 = [UIColor colorWithRed: 0.671 green: 0.671 blue: 0.671 alpha: 1];
    UIColor* fillColor2 = [UIColor colorWithRed: 0.247 green: 0.247 blue: 0.247 alpha: 1];
    UIColor* strokeColor2 = [UIColor colorWithRed: 0.188 green: 0.188 blue: 0.188 alpha: 1];
    UIColor* color = [UIColor colorWithRed: 0 green: 0.886 blue: 0 alpha: 1];
    
    //// Gradient Declarations
    NSArray* outerRectGradientColors = [NSArray arrayWithObjects:
                                        (id)strokeColor.CGColor,
                                        (id)fillColor.CGColor, nil];
    CGFloat outerRectGradientLocations[] = {0, 1};
    CGGradientRef outerRectGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)outerRectGradientColors, outerRectGradientLocations);
    NSArray* gradientColors = [NSArray arrayWithObjects:
                               (id)strokeColor2.CGColor,
                               (id)fillColor2.CGColor, nil];
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    //// Shadow Declarations
    UIColor* darkShadow = shadowColor2;
    CGSize darkShadowOffset = CGSizeMake(3.1, 3.1);
    CGFloat darkShadowBlurRadius = 5;
    UIColor* lightShadow = shadowColor3;
    CGSize lightShadowOffset = CGSizeMake(3.1, 3.1);
    CGFloat lightShadowBlurRadius = 5;
    
    //// Frames
    CGRect progressIndicatorFrame = self.bounds;
    
    //// Subframes
    CGRect group = CGRectMake(CGRectGetMinX(progressIndicatorFrame) + 10, CGRectGetMinY(progressIndicatorFrame) + 9, CGRectGetWidth(progressIndicatorFrame) - 25, 20);
    CGRect activeProgressFrame = CGRectMake(CGRectGetMinX(group) + floor(CGRectGetWidth(group) * 0.00000 + 0.5), CGRectGetMinY(group) + floor(CGRectGetHeight(group) * 0.00000 + 0.5), floor(CGRectGetWidth(group) * 1.00000 + 0.5) - floor(CGRectGetWidth(group) * 0.00000 + 0.5), floor(CGRectGetHeight(group) * 1.00000 + 0.5) - floor(CGRectGetHeight(group) * 0.00000 + 0.5));
    
    
    //// Abstracted Attributes
    CGRect progressTrackActiveRect = CGRectMake(CGRectGetMinX(activeProgressFrame) + 4, CGRectGetMinY(activeProgressFrame) + 5, CGRectGetWidth(activeProgressFrame) - 8, 10);
    
    
    //// Progress Bar
    {
        //// Border Drawing
        CGRect borderRect = CGRectMake(CGRectGetMinX(progressIndicatorFrame) + 2, CGRectGetMinY(progressIndicatorFrame) + 3, CGRectGetWidth(progressIndicatorFrame) - 5, 34);
        UIBezierPath* borderPath = [UIBezierPath bezierPathWithRoundedRect: borderRect cornerRadius: 4];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, darkShadowOffset, darkShadowBlurRadius, darkShadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [borderPath addClip];
        CGContextDrawLinearGradient(context, outerRectGradient,
                                    CGPointMake(CGRectGetMidX(borderRect), CGRectGetMinY(borderRect)),
                                    CGPointMake(CGRectGetMidX(borderRect), CGRectGetMaxY(borderRect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        
        ////// Border Inner Shadow
        CGRect borderBorderRect = CGRectInset([borderPath bounds], -lightShadowBlurRadius, -lightShadowBlurRadius);
        borderBorderRect = CGRectOffset(borderBorderRect, -lightShadowOffset.width, -lightShadowOffset.height);
        borderBorderRect = CGRectInset(CGRectUnion(borderBorderRect, [borderPath bounds]), -1, -1);
        
        UIBezierPath* borderNegativePath = [UIBezierPath bezierPathWithRect: borderBorderRect];
        [borderNegativePath appendPath: borderPath];
        borderNegativePath.usesEvenOddFillRule = YES;
        
        CGContextSaveGState(context);
        {
            CGFloat xOffset = lightShadowOffset.width + round(borderBorderRect.size.width);
            CGFloat yOffset = lightShadowOffset.height;
            CGContextSetShadowWithColor(context,
                                        CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                        lightShadowBlurRadius,
                                        lightShadow.CGColor);
            
            [borderPath addClip];
            CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(borderBorderRect.size.width), 0);
            [borderNegativePath applyTransform: transform];
            [[UIColor grayColor] setFill];
            [borderNegativePath fill];
        }
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
        
        
        
        //// ProgressTrack Drawing
        CGRect progressTrackRect = CGRectMake(CGRectGetMinX(progressIndicatorFrame) + 12, CGRectGetMinY(progressIndicatorFrame) + 12, CGRectGetWidth(progressIndicatorFrame) - 29, 14);
        UIBezierPath* progressTrackPath = [UIBezierPath bezierPathWithRoundedRect: progressTrackRect cornerRadius: 7];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, lightShadowOffset, lightShadowBlurRadius, lightShadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [progressTrackPath addClip];
        CGContextDrawLinearGradient(context, gradient,
                                    CGPointMake(CGRectGetMidX(progressTrackRect), CGRectGetMinY(progressTrackRect)),
                                    CGPointMake(CGRectGetMidX(progressTrackRect), CGRectGetMaxY(progressTrackRect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        
        ////// ProgressTrack Inner Shadow
        CGRect progressTrackBorderRect = CGRectInset([progressTrackPath bounds], -darkShadowBlurRadius, -darkShadowBlurRadius);
        progressTrackBorderRect = CGRectOffset(progressTrackBorderRect, -darkShadowOffset.width, -darkShadowOffset.height);
        progressTrackBorderRect = CGRectInset(CGRectUnion(progressTrackBorderRect, [progressTrackPath bounds]), -1, -1);
        
        UIBezierPath* progressTrackNegativePath = [UIBezierPath bezierPathWithRect: progressTrackBorderRect];
        [progressTrackNegativePath appendPath: progressTrackPath];
        progressTrackNegativePath.usesEvenOddFillRule = YES;
        
        CGContextSaveGState(context);
        {
            CGFloat xOffset = darkShadowOffset.width + round(progressTrackBorderRect.size.width);
            CGFloat yOffset = darkShadowOffset.height;
            CGContextSetShadowWithColor(context,
                                        CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                        darkShadowBlurRadius,
                                        darkShadow.CGColor);
            
            [progressTrackPath addClip];
            CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(progressTrackBorderRect.size.width), 0);
            [progressTrackNegativePath applyTransform: transform];
            [[UIColor grayColor] setFill];
            [progressTrackNegativePath fill];
        }
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
        
        
        
        //// Group
        {
            //// ProgressTrackActive Drawing
            UIBezierPath* progressTrackActivePath = [UIBezierPath bezierPathWithRoundedRect: progressTrackActiveRect cornerRadius: 5];
            [color setFill];
            [progressTrackActivePath fill];
        }
    }
    
    
    //// Cleanup
    CGGradientRelease(outerRectGradient);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

@end
