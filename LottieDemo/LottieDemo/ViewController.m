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
    // Do any additional setup after loading the view, typically from a nib.
    self.lottieLogo = [LOTAnimationView animationNamed:@"LottieLogo1"];
    self.lottieLogo.contentMode = UIViewContentModeScaleAspectFill;
    self.lottieLogo.frame = self.view.bounds;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
