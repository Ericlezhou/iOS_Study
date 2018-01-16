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

typedef NS_ENUM(NSInteger, ScrollDirection) {
    ScrollDirectionNone,
    ScrollDirectionUp,
    ScrollDirectionDown,
};

@interface CustomTableViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong) UIView *topFloatView;
@property (nonatomic, strong) UILabel *topBtn;
@property (nonatomic, strong) UILabel *middleBtn;
@property (nonatomic, strong) UILabel *bottomBtn;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat lastContentOffset;
@end

@implementation CustomTableViewController

- (UILabel *)topBtn {
    if (!_topBtn) {
        _topBtn = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [Utils getScreenWidth], 20)];
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
    [self adjustCustomTableViewHeaderWithScrollView:scrollView];
}

- (void)adjustCustomTableViewHeaderWithScrollView:(UIScrollView *)scrollView {
    NSLog(@"scrollView offset y : %f, inset : %f, contentSize y : %f", scrollView.contentOffset.y, scrollView.contentInset.top, scrollView.contentSize.height);
    
    if (self.topFloatView.superview && scrollView.contentInset.top + scrollView.contentOffset.y <= 0) {
        [self.topFloatView removeAllSubviews];
        [self.topFloatView removeFromSuperview];
        return;
    }
    
    ScrollDirection scrollDirection = ScrollDirectionNone;
    if (self.lastContentOffset > scrollView.contentOffset.y) {
        scrollDirection = ScrollDirectionDown;
    } else if (self.lastContentOffset < scrollView.contentOffset.y) {
        scrollDirection = ScrollDirectionUp;
    }
    self.lastContentOffset = scrollView.contentOffset.y;
    
    CGFloat top = scrollView.contentOffset.y + self.tableView.contentInset.top;
    if (self.topFloatView.superview) {
        top += self.topFloatView.frame.size.height;
    }
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:CGPointMake(0, top)];
    NSLog(@"indexPath row = %lu, section = %lu", indexPath.row, indexPath.section);
    if (!indexPath) {
        return;
    }
    //区分滚动方向分别处理
    if (scrollDirection == ScrollDirectionUp) {
        NSMutableArray *showedIndex = [NSMutableArray array];
        for (NSIndexPath *inPath in [self indexPathsOfCustomHeaderViewInTableView:self.tableView]) {
            if (inPath.section < indexPath.section) {
                [showedIndex addObject:inPath];
                continue;
            } else if (inPath.section == indexPath.section) {
                if (inPath.row < indexPath.row) {
                    [showedIndex addObject:inPath];
                    continue;
                } else if (inPath.row == indexPath.row) {
                    //------支持偏移量-开始-------
                    UITableViewCell *sourceTableViewCell = [self.tableView cellForRowAtIndexPath:inPath];
                    CGFloat appearOffset = 0;
                    if (sourceTableViewCell && [sourceTableViewCell conformsToProtocol:@protocol(CustomTableViewHeaderCellDelayShowProtocol)]) {
                        id<CustomTableViewHeaderCellDelayShowProtocol> delayShowCell = (id<CustomTableViewHeaderCellDelayShowProtocol>)sourceTableViewCell;
                        appearOffset = [delayShowCell customTableViewHeaderDelayShowOffset];
                    }
                    
                    CGFloat sourceTableViewCellOriginY = [self.tableView rectForRowAtIndexPath:inPath].origin.y;
                    CGFloat resultScrollY = appearOffset + sourceTableViewCellOriginY;
                    NSLog(@"ACT ScrollDirectionUp resultScrollY : %f ,top : %f", resultScrollY, top);
                    if (resultScrollY < top) {
                        NSLog(@"ACT ------ show add ------ ");
                        [showedIndex addObject:inPath];
                    }
                    //------支持偏移量-结束-------
                    continue;
                }
            }
        }
        for (NSIndexPath *inPath in showedIndex) {
            UIView *contentView = [self tableView:self.tableView customTableViewHeaderViewAtIndexPath:inPath];
            if (contentView) {
                //添加并展示view
                if (![[self.topFloatView subviews] containsObject:contentView]) {
                    [self.topFloatView addSubview:contentView];
                    [self layoutCustomHeaderView];
                }
            }
        }
    } else if (scrollDirection == ScrollDirectionDown) {
        
        NSMutableArray *hidedIndex = [NSMutableArray array];
        for (NSIndexPath *inPath in [self indexPathsOfCustomHeaderViewInTableView:self.tableView]) {
            if (inPath.section < indexPath.section) {
                continue;
            } else if (inPath.section == indexPath.section) {
                if (inPath.row < indexPath.row) {
                    continue;
                } else if (inPath.row == indexPath.row) {
                    //------支持偏移量-开始-------
                    UITableViewCell *sourceTableViewCell = [self.tableView cellForRowAtIndexPath:inPath];
                    CGFloat disAppearOffset = 0;
                    if (sourceTableViewCell && [sourceTableViewCell conformsToProtocol:@protocol(CustomTableViewHeaderCellDelayShowProtocol)]) {
                        id<CustomTableViewHeaderCellDelayShowProtocol> delayShowCell = (id<CustomTableViewHeaderCellDelayShowProtocol>)sourceTableViewCell;
                        disAppearOffset = [delayShowCell customTableViewHeaderDelayHideOffset];
                    }
                    CGRect rect = [self.tableView rectForRowAtIndexPath:inPath];
                    CGFloat sourceTableViewCellOriginY = rect.origin.y + rect.size.height;
                    CGFloat resultScrollY = sourceTableViewCellOriginY - disAppearOffset;
                    NSLog(@"ACT ScrollDirectionDown resultScrollY : %f ,top : %f", resultScrollY, top);
                    if (resultScrollY > top) {
                        NSLog(@"ACT ------ hide add ------ ");
                        [hidedIndex addObject:inPath];
                    }
                    //------支持偏移量-结束-------
                    continue;
                } else {
                    [hidedIndex addObject:inPath];
                    continue;
                }
            }
        }
        for (NSIndexPath *inPath in hidedIndex) {
            UIView *contentView = [self tableView:self.tableView customTableViewHeaderViewAtIndexPath:inPath];
            if (contentView) {
                //消失
                if (self.topFloatView.superview && [[self.topFloatView subviews] containsObject:contentView]) {
                    [contentView removeFromSuperview];
                    [self layoutCustomHeaderView];
                }
            }
        }
    }
}

- (void)layoutCustomHeaderView {
    NSArray *subviews = [self.topFloatView subviews];
    if (subviews.count) {
        if (!self.topFloatView.superview) {
            [self.view addSubview:self.topFloatView];
            self.topFloatView.alpha = 1;
        }
        CGFloat sumHeight = 0;
        CGFloat maxWidth = 0;
        for (UIView *subview in [self.topFloatView subviews]) {
            subview.frame = CGRectMake(subview.frame.origin.x, sumHeight, subview.frame.size.width, subview.frame.size.height);
            sumHeight += subview.frame.size.height;
            maxWidth = subview.frame.size.width > maxWidth ? subview.frame.size.width : maxWidth;
        }
        self.topFloatView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y + self.tableView.contentInset.top, maxWidth, sumHeight);
    } else {
        if (self.topFloatView.superview) {
            self.topFloatView.alpha = 0;
            self.topFloatView.frame = CGRectZero;
            [self.topFloatView removeFromSuperview];
        }
    }
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
