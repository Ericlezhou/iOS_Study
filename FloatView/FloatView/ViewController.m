//
//  ViewController.m
//  FloatView
//
//  Created by Eric on 2017/3/21.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import "ViewController.h"
#import "QLFloatLayoutView.h"

@interface ViewController () <QLFloatLayoutViewDelegate, QLFloatLayoutViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    QLFloatLayoutView *floatView = [[QLFloatLayoutView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height  * 0.5)];
//    floatView.padding = UIEdgeInsetsMake(20, 10, 20, 10);
    floatView.itemMargins = UIEdgeInsetsMake(0, 0, 10, 10);
    floatView.maximumItemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 200, CGFLOAT_MAX);
//    floatView.horizonAlign = YES;
    [self.view addSubview:floatView];
    
    floatView.delegate = self;
    floatView.dataSource = self;
    [floatView reloadData];
}

- (NSString *)makeRandomTitleWithIndex:(NSUInteger) index
{
    NSString *result = @"";
    NSUInteger max =  random() % 20;;
    for (NSUInteger i = 0; i < max; i++) {
        result = [NSString stringWithFormat:@"%@發", result];
    }
    result = [NSString stringWithFormat:@"%@+%lu", result, index];
    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - delegate
-(void)floatLayoutView:(QLFloatLayoutView *)floatLayoutView didSelectItemViewAtIndex:(NSUInteger)index
{
    NSLog(@"%lu", index);
}


#pragma mark - datasource
- (NSInteger)numberOfItemsForFloatLayoutView:(QLFloatLayoutView *)floatLayoutView
{
    return 20;
}

-(UIView *)floatLayoutView:(QLFloatLayoutView *)floatLayoutView itemViewForIndex:(NSUInteger)index
{
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.text = [self makeRandomTitleWithIndex:index];
    [button setBackgroundColor:[UIColor greenColor]];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:button.titleLabel.text];
    [titleString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, [titleString length])];
    [button setAttributedTitle: titleString forState:UIControlStateNormal];
    return button;
}

@end
