//
//  CustomTableViewController.m
//  CustomTableViewHeader
//
//  Created by Eric on 2017/12/29.
//  Copyright © 2017年 nexus. All rights reserved.
//

#import "CustomTableViewController.h"
#import "Utils.h"
#import "CustomHeaderView.h"
#import "UIView+additions.h"
typedef NS_ENUM(NSInteger, ScrollDirection) {
    ScrollDirectionNone,
    ScrollDirectionUp,
    ScrollDirectionDown,
};

@interface CustomTableViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, CustomHeaderViewProtocol>
@property (nonatomic, strong) UIView *topFloatView;
@property (nonatomic, strong) UILabel *topBtn;
@property (nonatomic, strong) UILabel *middleBtn;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat lastContentOffset;
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
        _middleBtn = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [Utils getScreenWidth], 60)];
        _middleBtn.backgroundColor = [UIColor yellowColor];
        _middleBtn.textColor = [UIColor blackColor];
    }
    return _middleBtn;
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
        self.topFloatView = [[UIView alloc] initWithFrame:CGRectZero];
        self.topFloatView.alpha = 0;
    }
}

- (CGPoint)contentStartOrigin {
    CGFloat originY = self.tableView.contentInset.top;
    CGFloat originX = self.tableView.contentInset.left;
    return CGPointMake(originX, originY);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollView offset y : %f, inset : %f, contentSize y : %f", scrollView.contentOffset.y, scrollView.contentInset.top, scrollView.contentSize.height);
    ScrollDirection scrollDirection = ScrollDirectionNone;
    if (self.lastContentOffset > scrollView.contentOffset.y) {
        scrollDirection = ScrollDirectionDown;
    } else if (self.lastContentOffset < scrollView.contentOffset.y) {
        scrollDirection = ScrollDirectionUp;
    }
    self.lastContentOffset = scrollView.contentOffset.y;
    NSLog(@"%@",scrollDirection == ScrollDirectionDown ? @"向下" : @"向上");

    CGFloat top = scrollView.contentOffset.y + self.tableView.contentInset.top;
    if (scrollDirection == ScrollDirectionUp) {
         top += self.topFloatView.frame.size.height;
    }else{
        if (self.topFloatView.superview && [[self.topFloatView subviews] lastObject]) {
            top += (self.topFloatView.frame.size.height - ((UIView *)[[self.topFloatView subviews] lastObject]).frame.size.height);
        }
    }
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:CGPointMake(0, top)];
    NSLog(@"indexPath row = %lu, section = %lu", indexPath.row, indexPath.section);

    NSMutableArray *showedIndex = [NSMutableArray array];
    NSMutableArray *hidedIndex = [NSMutableArray array];
    for (NSIndexPath *inPath in [self indexPathsOfCustomHeaderViewInTableView:self.tableView]) {
        if (inPath.section < indexPath.section) {
            [showedIndex addObject:inPath];
            continue;
        }else if (inPath.section == indexPath.section) {
            if (inPath.row <= indexPath.row) {
                [showedIndex addObject:inPath];
                continue;
            }
        }
        [hidedIndex addObject:inPath];
    }
    
    for (NSIndexPath *inPath in showedIndex) {
        UIView *contentView = [self tableView:self.tableView customTableViewHeaderViewAtIndexPath:inPath];
        if (contentView) {
            if (scrollDirection == ScrollDirectionUp) {
                //出现
                if (![[self.topFloatView subviews] containsObject:contentView]) {
                    [self.topFloatView addSubview:contentView];
                }
                [self refreshCustomHeaderView];
            }
        }
    }
    for (NSIndexPath *inPath in hidedIndex) {
        UIView *contentView = [self tableView:self.tableView customTableViewHeaderViewAtIndexPath:inPath];
        if (contentView) {
            if (scrollDirection == ScrollDirectionDown) {
                if (self.topFloatView.superview && [[self.topFloatView subviews] containsObject:contentView]) {
                    [contentView removeFromSuperview];
                    [self refreshCustomHeaderView];
                }
            }
        }
    }
}

- (void)refreshCustomHeaderView {
    NSArray *subviews = [self.topFloatView subviews];
    if (subviews.count) {
        if (!self.topFloatView.superview) {
//            self.topFloatView.alpha = 0;
            [self.view addSubview:self.topFloatView];
//            [UIView animateWithDuration:0.3 animations:^{
                self.topFloatView.alpha = 1;
//            }];
        }
        CGFloat sumHeight = 0;
        CGFloat maxWidth = 0;
        for (UIView *subview in [self.topFloatView subviews]) {
            subview.frame = CGRectMake(subview.frame.origin.x, sumHeight, subview.frame.size.width, subview.frame.size.height);
            sumHeight += subview.frame.size.height;
            maxWidth = subview.frame.size.width > maxWidth ? subview.frame.size.width : maxWidth;
        }
        
        self.topFloatView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, maxWidth, sumHeight);
    }else{
        static BOOL removingAnimation = NO;
        if (self.topFloatView.superview && !removingAnimation) {
//            self.topFloatView.alpha = 1;
//            [UIView animateWithDuration:0.3 animations:^{
//                removingAnimation = YES;
//                self.topFloatView.alpha = 0;
//            } completion:^(BOOL finished) {
//                removingAnimation = NO;
                [self.topFloatView removeFromSuperview];
                [self.topFloatView removeAllSubviews];
                self.topFloatView.frame = CGRectZero;
//            }];
        }
    }
}

#pragma mark - CustomTableViewProtocol
- (void)didClickCustomHeaderView:(CustomHeaderView *)headerView {
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
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
        cellColor = [UIColor yellowColor];
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

- (NSArray *)indexPathsOfCustomHeaderViewInTableView:(UITableView *)tableView {
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[NSIndexPath indexPathForRow:4 inSection:0]];
    [array addObject:[NSIndexPath indexPathForRow:4 inSection:1]];
    return array;
}

- (UIView *)tableView:(UITableView *)tableView customTableViewHeaderViewAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4 && indexPath.section == 0) {
        [self.topBtn setText:[NSString stringWithFormat:@"    row = %lu, section = %lu", indexPath.row, indexPath.section]];
        return self.topBtn;
    }
    
    if (indexPath.row == 4 && indexPath.section == 1) {
        [self.middleBtn setText:[NSString stringWithFormat:@"    row = %lu, section = %lu", indexPath.row, indexPath.section]];
        return self.middleBtn;
    }
    return nil;
}
@end
