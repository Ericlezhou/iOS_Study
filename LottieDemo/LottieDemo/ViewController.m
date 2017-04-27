//
//  ViewController.m
//  LottieDemo
//
//  Created by Eric on 2017/4/26.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import "ViewController.h"
#import "Lottie.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *pauseBtn;
@property (nonatomic, strong) LOTAnimationView *lottieLogo;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animationID = self.animationID.length ? self.animationID : @"IconTransitions";
    self.lottieLogo = [LOTAnimationView animationNamed:self.animationID];
    self.lottieLogo.contentMode = UIViewContentModeScaleAspectFit;
    self.lottieLogo.frame = self.view.bounds;
    [self.lottieLogo setLoopAnimation:YES];
    [self.view addSubview:self.lottieLogo];
    [self.view bringSubviewToFront:self.playBtn];
    [self.view bringSubviewToFront:self.pauseBtn];
    [self.view bringSubviewToFront:self.resetBtn];
}
- (IBAction)playBtn:(id)sender {
    [self.lottieLogo play];
}

- (IBAction)pauseBtn:(id)sender {
    [self.lottieLogo pause];
}

- (IBAction)resetBtn:(id)sender {
    [self.lottieLogo setAnimationProgress:0];
    [self.lottieLogo play];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.lottieLogo play];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.lottieLogo.isAnimationPlaying) {
        [self.lottieLogo pause];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
