//
//  JHZCustomProgressBarClipView.m
//  JHZCustomProgressBar
//
//  Created by Eric on 2018/5/13.
//  Copyright © 2018年 nexus. All rights reserved.
//

#import "JHZCustomProgressBarClipView.h"

@implementation JHZCustomProgressBarClipView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _clipProgress = 0;
        _clipProgressTintColor = [UIColor greenColor];
        _clipTrackTintColor = [UIColor grayColor];
        _clipTagColor = [UIColor redColor];
    }
    return self;
}

- (void)setClipProgress:(float)clipProgress {
    _clipProgress = clipProgress;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    //// Fixed Frame
    CGRect progressIndicatorFrame = self.bounds;
    NSLog(@"progressIndicatorFrame = %@", @(progressIndicatorFrame));
    CGRect progressTrackRect = CGRectMake(CGRectGetMinX(progressIndicatorFrame), CGRectGetMinY(progressIndicatorFrame), CGRectGetWidth(progressIndicatorFrame), CGRectGetHeight(progressIndicatorFrame));
    NSLog(@"progressTrackRect = %@",@(progressTrackRect));
    
    //// Sub Active Frame
    CGRect activeProgressFrame = CGRectMake(CGRectGetMinX(progressIndicatorFrame), CGRectGetMinY(progressIndicatorFrame) + 10, CGRectGetWidth(progressIndicatorFrame), 20);
    NSLog(@"activeProgressFrame = %@",@(activeProgressFrame));
    CGRect progressTrackActiveRect = CGRectMake(CGRectGetMinX(activeProgressFrame),
                                                CGRectGetMinY(activeProgressFrame),
                                                (CGRectGetWidth(activeProgressFrame)) * self.clipProgress,
                                                CGRectGetHeight(activeProgressFrame));
    NSLog(@"progressTrackActiveRect = %@",@(progressTrackActiveRect));
    
    //// Drawing Progress Bar
    //// Track
    {
        UIBezierPath* progressTrackPath = [UIBezierPath bezierPathWithRoundedRect: progressTrackRect cornerRadius: 0];
        [_clipTrackTintColor setFill];
        [progressTrackPath fill];
    }
    //// Progress
    {
        UIBezierPath* progressTrackActivePath = [UIBezierPath bezierPathWithRoundedRect: progressTrackActiveRect cornerRadius: 0];
        [_clipProgressTintColor setFill];
        [progressTrackActivePath fill];
    }
}

@end
