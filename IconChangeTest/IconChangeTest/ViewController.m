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
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@end

@implementation ViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)enterForgeGround
{
    NSLog(@"%@", [[UIApplication sharedApplication] alternateIconName]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    if ([[UIApplication sharedApplication] supportsAlternateIcons])
    {
        NSLog(@"supportsAlternateIcons");
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterForgeGround) name:UIApplicationDidBecomeActiveNotification object:nil];
        NSString *iconName = [[UIApplication sharedApplication] alternateIconName];
        if (!iconName) {
            [self.segment setSelectedSegmentIndex:0];
        }else if ([iconName isEqualToString:@"blue"]){
            [self.segment setSelectedSegmentIndex:1];
        }else if ([iconName isEqualToString:@"green"]){
            [self.segment setSelectedSegmentIndex:2];
        }
    }
    else
    {
        NSLog(@"not supportsAlternateIcons");
    }
}


- (IBAction)changeIcon:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
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
- (IBAction)requetReview:(UIButton *)sender
{
    [SKStoreReviewController requestReview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
