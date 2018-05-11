//
//  ViewController.m
//  JHZCustomProgressBar
//
//  Created by Eric on 2018/5/11.
//  Copyright © 2018年 nexus. All rights reserved.
//

#import "ViewController.h"
#import "JHZCustomProgressBar.h"
const NSTimeInterval JHZACProgressBarStripesAnimationTime = 1.0f / 30.0f;
const NSTimeInterval JHZACProgressBarSumDuraton = 10.0;
@interface ViewController ()
@property (nonatomic, strong) NSTimer *progressTimer;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) JHZCustomProgressBar *progressView;
@end

@implementation ViewController

- (void)dealloc {
    [self destoryProgressTimer];
}

- (void)destoryProgressTimer {
    if (self.progressTimer && [self.progressTimer isValid]) {
        [self.progressTimer invalidate];
        self.progressTimer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(20, 200, 80, 40);
    [self.button setTitle:@"开始" forState:UIControlStateNormal];
    [self.button setTitle:@"结束" forState:UIControlStateSelected];
    self.button.backgroundColor = [UIColor blueColor];
    [self.button setSelected:NO];
    [self.button addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    self.progressView = [[JHZCustomProgressBar alloc] initWithFrame:CGRectMake(20, 100, self.view.bounds.size.width - 40, 40)];
    self.progressView.progress = 0;
    [self.view addSubview:self.progressView];
}

- (void)clicked:(id)sender {
    if (self.button.selected) {
        self.button.selected = NO;
        [self destoryProgressTimer];
    } else {
        self.button.selected = YES;
        [self destoryProgressTimer];
        self.progressTimer = [NSTimer timerWithTimeInterval:JHZACProgressBarStripesAnimationTime target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
    }
}

- (void)updateProgress {
    if (self.progressView.progress < 1.0) {
        self.progressView.progress += (JHZACProgressBarStripesAnimationTime / JHZACProgressBarSumDuraton);
    } else {
//        [self destoryProgressTimer];
        self.progressView.progress = 0;
    }
    NSLog(@"progress:%f", self.progressView.progress);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
