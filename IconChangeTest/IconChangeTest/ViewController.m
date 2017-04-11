//
//  ViewController.m
//  IconChangeTest
//
//  Created by Eric on 2017/4/11.
//  Copyright © 2017年 Eric. All rights reserved.
//
#import "ViewController.h"
#import "StoreKit/SKStoreReviewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if ([[UIApplication sharedApplication] supportsAlternateIcons]) {
        NSLog(@"supportsAlternateIcons");
    }else{
        NSLog(@"not supportsAlternateIcons");
    }
}
- (IBAction)changeIcon:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [[UIApplication sharedApplication] setAlternateIconName:nil completionHandler:^(NSError * _Nullable error) {
                NSLog(@"error = %@", error.localizedDescription);
            }];
            break;
        case 1:
            [[UIApplication sharedApplication] setAlternateIconName:@"blue" completionHandler:^(NSError * _Nullable error) {
                NSLog(@"error = %@", error.localizedDescription);
            }];
            break;
        case 2:
            [[UIApplication sharedApplication] setAlternateIconName:@"green" completionHandler:^(NSError * _Nullable error) {
                NSLog(@"error = %@", error.localizedDescription);
            }];
            break;
            
        default:
            break;
    }

}
- (IBAction)requetReview:(UIButton *)sender {
    [SKStoreReviewController requestReview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
