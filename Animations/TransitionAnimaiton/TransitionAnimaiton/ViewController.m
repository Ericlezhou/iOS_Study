//
//  ViewController.m
//  TransitionAnimaiton
//
//  Created by Eric on 2017/6/29.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import "ViewController.h"
typedef NS_ENUM(NSInteger, AnimationDirection){
    AnimationDirectionPositive = 1,
    AnimationDirectionNegative = -1
};

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *loadingView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loadingView.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (IBAction)start:(id)sender {
//    [UIView transitionWithView:self.loadingView duration:0.3 options:UIViewAnimationOptionTransitionCurlDown animations:^{
//        self.loadingView.hidden = NO;
//    } completion:^(BOOL finished) {
//        
//    }];
    static int num = 1;
    NSString *text = num == 1 ? @"Readying ..." : @"Loadiing ...";
    num = num == 1 ? 0 : 1;
    [self cubeTransitionLabel:self.loadingView newText:text direction:AnimationDirectionNegative];
}

- (void)cubeTransitionLabel:(UILabel *)label newText:(NSString *)text direction:(AnimationDirection) direction{
    
    UILabel *helper = [[UILabel alloc] init];
    helper.frame = label.frame;
    helper.text = text;
    helper.font = label.font;
    helper.textColor = label.textColor;
    helper.textAlignment = label.textAlignment;
    helper.backgroundColor = label.backgroundColor;
    
    CGFloat auxLabelOffset = direction * label.frame.size.height / 2.0;
    
    CGAffineTransform transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 0.1), CGAffineTransformMakeTranslation(0, auxLabelOffset));
    helper.transform = transform;
    [label.superview addSubview:helper];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        helper.transform = CGAffineTransformIdentity;
        CGAffineTransform transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 0.1), CGAffineTransformMakeTranslation(0, -auxLabelOffset));
        label.transform = transform;
    } completion:^(BOOL finished) {
        label.text = text;
        label.transform = CGAffineTransformIdentity;
        [helper removeFromSuperview];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
