//
//  SlideButton.m
//  TouchRadio
//
//  Created by Eric on 16/3/15.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "SlideButton.h"
#import "ViewController.h"
@implementation SlideButton


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.multipleTouchEnabled = NO;
    return  self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ViewController * ctrl = nil;
    if ([self.delegate isKindOfClass:[ViewController class]]) {
        ctrl = (ViewController *)self.delegate;
        ctrl.label.hidden = NO;
        ctrl.label.text = @"手指上滑，取消发送";
        [ctrl.view setNeedsLayout];
    }
    
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ViewController * ctrl = nil;
    if ([self.delegate isKindOfClass:[ViewController class]]) {
        ctrl = (ViewController *)self.delegate;
        ctrl.label.hidden = YES;
        [ctrl.view setNeedsLayout];
    }
    [ctrl.view setNeedsLayout];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *t = [touches anyObject];
    CGPoint point = [t locationInView:self.delegate.view];
    CGFloat scrHeight = [UIScreen mainScreen].bounds.size.height;
    ViewController * ctl =  (ViewController*)self.delegate;
    if (scrHeight - point.y > self.bounds.size.height + 100) {
        ctl.label.hidden = YES;
        NSLog(@"取消成功");
    }else{
        NSLog(@"发送成功");
        ctl.label.hidden = YES;
    }
    [ctl.view setNeedsLayout];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *t = [touches anyObject];
    CGPoint point = [t locationInView:self.delegate.view];
    ViewController * ctl =  (ViewController*)self.delegate;
    if (point.y < self.frame.origin.y - 100) {
        ctl.label.text = @"松开手指，取消发送";
        [ctl.view setNeedsLayout];
    }else{
        ctl.label.text = @"手指上滑，取消发送";
        [ctl.view setNeedsLayout];
    }
}

@end
