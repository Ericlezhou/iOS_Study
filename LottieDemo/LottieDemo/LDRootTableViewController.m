//
//  LDRootTableViewController.m
//  LottieDemo
//
//  Created by Eric on 2017/4/26.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import "LDRootTableViewController.h"
#import "ViewController.h"

@interface LDRootTableViewController ()

@end

@implementation LDRootTableViewController

+ (NSArray *)animationSet
{
    static NSArray *_titles;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _titles = @[@"9squares-AlBoardman",
                    @"HamburgerArrow",
                    @"520",
                    @"IconTransitions",
                    @"LottieLogo1_masked",
                    @"LottieLogo1",
                    @"LottieLogo2",
                    @"MotionCorpse-Jrcanest",
                    @"PinJump",
                    @"TwitterHeart",
                    @"vcTransition1",
                    @"vcTransition2",
                    @"Watermelon",
                    @"data",
                    @"JHZRecordLottieAnimation",
                    @"btn_flash"];
    });
    return _titles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"选择一个动画看看";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self class] animationSet] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    cell.textLabel.text = [[[self class] animationSet] objectAtIndex:[indexPath row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ViewController *ctl = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
    ctl.animationID = [[[self class] animationSet] objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:ctl animated:YES];
}
@end
