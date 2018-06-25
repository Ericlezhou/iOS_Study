//
//  LRTargetNavigationTransitionViewController.m
//  LRAnimation
//
//  Created by Eric on 2018/2/8.
//  Copyright © 2018年 le zhou. All rights reserved.
//

#import "LRTargetNavigationTransitionViewController.h"

@interface LRTargetNavigationTransitionViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation LRTargetNavigationTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    if (self.imagName.length) {
        [_imageView setImage:[UIImage imageNamed:self.imagName]];
    }
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAction:)];
    [_imageView addGestureRecognizer:tapRec];
}

- (void)dismissAction:(id)sender {
    [self popoverPresentationController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
