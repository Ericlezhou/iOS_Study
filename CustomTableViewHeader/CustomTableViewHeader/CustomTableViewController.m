//
//  CustomTableViewController.m
//  CustomTableViewHeader
//
//  Created by Eric on 2017/12/29.
//  Copyright © 2017年 nexus. All rights reserved.
//

#import "CustomTableViewController.h"
#import "Utils.h"
#import "UIView+additions.h"
#import "CustomTableViewCell.h"
#import "CustomTableViewHeaderCellDelayShowProtocol.h"
#import "CustomTableViewHeaderHelper.h"

@interface CustomTableViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, CustomTableViewHeaderHelperDataSource>
@property (nonatomic, strong) UILabel *topBtn;
@property (nonatomic, strong) UILabel *middleBtn;
@property (nonatomic, strong) UILabel *bottomBtn;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CustomTableViewHeaderHelper *tableViewHeaderHelper;
@end

@implementation CustomTableViewController

- (UILabel *)topBtn {
    if (!_topBtn) {
        _topBtn = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [Utils getScreenWidth], 40)];
        _topBtn.backgroundColor = [UIColor redColor];
        _topBtn.textColor = [UIColor blackColor];
    }
    return _topBtn;
}
- (UILabel *)middleBtn {
    if (!_middleBtn) {
        _middleBtn = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [Utils getScreenWidth], 30)];
        _middleBtn.backgroundColor = [UIColor yellowColor];
        _middleBtn.textColor = [UIColor blackColor];
    }
    return _middleBtn;
}
- (UILabel *)bottomBtn {
    if (!_bottomBtn) {
        _bottomBtn = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [Utils getScreenWidth], 80)];
        _bottomBtn.backgroundColor = [UIColor blueColor];
        _bottomBtn.textColor = [UIColor blackColor];
    }
    return _bottomBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    if (!self.tableView) {
        CGFloat screenH = [Utils getScreenHeight];
        CGRect rect = CGRectMake(0, ceilf(screenH * 0.3), [Utils getScreenWidth], ceilf(screenH * 0.7));
        self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        [self.view addSubview:self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
    }
}

- (CustomTableViewHeaderHelper *)tableViewHeaderHelper {
    if (!_tableViewHeaderHelper) {
        _tableViewHeaderHelper = [[CustomTableViewHeaderHelper alloc] initWithTableViewHostView:self.view];
        _tableViewHeaderHelper.dataSource = self;
    }
    return _tableViewHeaderHelper;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableViewHeaderHelper tableViewDidScroll:(UITableView *)scrollView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ssIdentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ssIdentifier"];
    }
    UIColor *cellColor = [UIColor whiteColor];
    if (indexPath.section == 0) {
        cellColor = [UIColor redColor];
    } else if (indexPath.section == 1) {
        if (indexPath.row == 4) {
            cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomTableViewCell"];
        } else {
            cellColor = [UIColor yellowColor];
        }
    } else if (indexPath.section == 2) {
        cellColor = [UIColor blueColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"row = %lu, section = %lu", indexPath.row, indexPath.section];
    cell.backgroundColor = cellColor;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 40;
    if (indexPath.section == 0) {
        height = 40;
    } else if (indexPath.section == 1) {
        height = 60;
    } else if (indexPath.section == 2) {
        height = 80;
    }
    return height;
}

#pragma mark -
#pragma mark - CustomTableViewHeaderHelperDataSource
- (NSArray *)indexPathsOfCustomHeaderViewInTableView:(UITableView *)tableView {
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[NSIndexPath indexPathForRow:0 inSection:0]];
    [array addObject:[NSIndexPath indexPathForRow:4 inSection:1]];
    [array addObject:[NSIndexPath indexPathForRow:4 inSection:2]];
    return array;
}

- (UIView *)tableView:(UITableView *)tableView customTableViewHeaderViewAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        [self.topBtn setText:[NSString stringWithFormat:@"    row = %lu, section = %lu", indexPath.row, indexPath.section]];
        return self.topBtn;
    }
    
    if (indexPath.row == 4 && indexPath.section == 1) {
        [self.middleBtn setText:[NSString stringWithFormat:@"    row = %lu, section = %lu", indexPath.row, indexPath.section]];
        return self.middleBtn;
    }
    
    if (indexPath.row == 4 && indexPath.section == 2) {
        [self.bottomBtn setText:[NSString stringWithFormat:@"    row = %lu, section = %lu", indexPath.row, indexPath.section]];
        return self.bottomBtn;
    }
    return nil;
}
@end
