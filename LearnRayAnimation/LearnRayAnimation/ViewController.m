//
//  ViewController.m
//  LearnRayAnimation
//
//  Created by le zhou on 2017/6/24.
//  Copyright © 2017年 le zhou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *lraBtn;
@property (weak, nonatomic) IBOutlet UITextField *lraTextField;
@property (weak, nonatomic) IBOutlet UILabel *cloud1;
@property (weak, nonatomic) IBOutlet UILabel *cloud2;
@property (weak, nonatomic) IBOutlet UILabel *cloud3;
@property (weak, nonatomic) IBOutlet UILabel *cloud4;
@property (weak, nonatomic) IBOutlet UIButton *springBtn;
@property (weak, nonatomic) IBOutlet UILabel *departingLabel;

@end

@implementation ViewController

- (CGRect)makeRectBeforeAnimation:(CGRect) rect{
    return CGRectMake(rect.origin.x - self.view.bounds.size.width, rect.origin.y, rect.size.width, rect.size.height);
}

- (CGRect)makeRectAfterAnimation:(CGRect) rect{
    return CGRectMake(rect.origin.x + self.view.bounds.size.width, rect.origin.y, rect.size.width, rect.size.height);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //normal animation
    self.lraBtn.frame = [self makeRectBeforeAnimation:self.lraBtn.frame];
    self.lraTextField.frame = [self makeRectBeforeAnimation:self.lraTextField.frame];
    self.cloud1.alpha = 0;
    self.cloud2.alpha = 0;
    self.cloud3.alpha = 0;
    self.cloud4.alpha = 0;
    
    //spring animation
    CGRect oriSpringFrame = self.springBtn.frame;
    CGRect lowerFrame = CGRectMake(oriSpringFrame.origin.x, oriSpringFrame.origin.y + 30, oriSpringFrame.size.width, oriSpringFrame.size.height);
    self.springBtn.frame = lowerFrame;
    self.springBtn.alpha = 0;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //normal animation
    [UIView animateWithDuration:0.5 animations:^{
        self.lraBtn.frame = [self makeRectAfterAnimation:self.lraBtn.frame];
    }];
    
    [UIView animateWithDuration:0.5 delay:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
        self.lraTextField.frame = [self makeRectAfterAnimation:self.lraTextField.frame];
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.cloud1.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            self.cloud1.alpha = 0;
        } completion:^(BOOL finished) {
            [self.cloud1 removeFromSuperview];
        }];
    }];
    
    [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.cloud2.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            self.cloud2.alpha = 0;
        } completion:^(BOOL finished) {
            [self.cloud2 removeFromSuperview];
        }];
    }];
    
    [UIView animateWithDuration:0.9 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.cloud3.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            self.cloud3.alpha = 0;
        } completion:^(BOOL finished) {
            [self.cloud3 removeFromSuperview];
        }];
    }];
    
    [UIView animateWithDuration:1.1 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.cloud4.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            self.cloud4.alpha = 0;
        } completion:^(BOOL finished) {
            [self.cloud4 removeFromSuperview];
        }];
    }];
    //spring animaiton
    [UIView animateWithDuration:0.5 delay:1 usingSpringWithDamping:0.2 initialSpringVelocity:1 options:UIViewAnimationOptionTransitionNone animations:^{
        CGRect oriSpringFrame = self.springBtn.frame;
        CGRect higherFrame = CGRectMake(oriSpringFrame.origin.x, oriSpringFrame.origin.y - 30, oriSpringFrame.size.width, oriSpringFrame.size.height);
        self.springBtn.frame = higherFrame;
        self.springBtn.alpha = 1;
    } completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)greenBtnClicked:(id)sender {
    //keyFrame animation
    [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.3 animations:^{
            CGPoint center = self.departingLabel.center;
            self.departingLabel.center = CGPointMake(center.x - 50, center.y + 50);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.7 animations:^{
            CGPoint center = self.departingLabel.center;
            self.departingLabel.center = CGPointMake(center.x + 100, center.y);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.7 relativeDuration:0.3 animations:^{
            CGPoint center = self.departingLabel.center;
            self.departingLabel.center = CGPointMake(center.x - 50, center.y - 50);
        }];
    } completion:nil];
}


- (IBAction)springBtnClick:(id)sender {
    static int num = 0;
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionNone animations:^{
        CGFloat width = num % 2 == 0 ? self.springBtn.bounds.size.width + 80 : self.springBtn.bounds.size.width - 80;
        CGPoint center = num % 2 == 0 ? CGPointMake(self.springBtn.center.x, self.springBtn.center.y + 60) : CGPointMake(self.springBtn.center.x, self.springBtn.center.y - 60);
        self.springBtn.bounds = CGRectMake(0, 0, width, self.springBtn.bounds.size.height);
        self.springBtn.center = center;
    } completion:^(BOOL finished) {
        num = num % 2 == 0 ? 1 : 0;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end