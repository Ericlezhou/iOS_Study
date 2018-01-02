//
//  ViewController.m
//  CustomTableViewHeader
//
//  Created by Eric on 2017/12/29.
//  Copyright © 2017年 nexus. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *jumpAction;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    _jumpAction.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    _jumpAction.titleLabel.textColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)jumpActionFired:(id)sender {
    CustomTableViewController *cstVC = [[CustomTableViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:cstVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
