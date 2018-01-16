//
//  CustomTableViewHeaderHelper.m
//  CustomTableViewHeader
//
//  Created by Eric on 2018/1/16.
//  Copyright © 2018年 nexus. All rights reserved.
//

#import "CustomTableViewHeaderHelper.h"
#import "UIView+additions.h"
typedef NS_ENUM(NSInteger, ScrollDirection) {
    ScrollDirectionNone,
    ScrollDirectionUp,
    ScrollDirectionDown,
};

@interface CustomTableViewHeaderHelper ()
@property (nonatomic, assign) CGFloat lastContentOffset;
@property (nonatomic, strong) UIView *hostView;
@end
@implementation CustomTableViewHeaderHelper

- (instancetype)initWithTableViewHostView:(UIView *)hostView {
    if (self = [super init]) {
        if (hostView) {
            self.hostView = hostView;
            self.topFloatView = [[UIView alloc] initWithFrame:CGRectZero];
            self.topFloatView.alpha = 0;
        }
    }
    return self;
}
- (void)tableViewDidScroll:(UITableView *)tableView {
    if (!tableView || ![tableView isKindOfClass:[UITableView class]]) {
        return;
    }
    UIScrollView *scrollView = tableView;
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
    
    CGFloat top = scrollView.contentOffset.y + tableView.contentInset.top;
    if (self.topFloatView.superview) {
        top += self.topFloatView.frame.size.height;
    }
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:CGPointMake(0, top)];
    NSLog(@"indexPath row = %lu, section = %lu", indexPath.row, indexPath.section);
    if (!indexPath) {
        return;
    }
    //区分滚动方向分别处理
    if (scrollDirection == ScrollDirectionUp) {
        NSMutableArray *showedIndex = [NSMutableArray array];
        for (NSIndexPath *inPath in [self __indexPathsOfCustomHeaderViewInTableView:tableView]) {
            if (inPath.section < indexPath.section) {
                [showedIndex addObject:inPath];
                continue;
            } else if (inPath.section == indexPath.section) {
                if (inPath.row < indexPath.row) {
                    [showedIndex addObject:inPath];
                    continue;
                } else if (inPath.row == indexPath.row) {
                    //------支持偏移量-开始-------
                    UITableViewCell *sourceTableViewCell = [tableView cellForRowAtIndexPath:inPath];
                    CGFloat appearOffset = 0;
                    if (sourceTableViewCell && [sourceTableViewCell conformsToProtocol:@protocol(CustomTableViewHeaderCellDelayShowProtocol)]) {
                        id<CustomTableViewHeaderCellDelayShowProtocol> delayShowCell = (id<CustomTableViewHeaderCellDelayShowProtocol>)sourceTableViewCell;
                        if ([delayShowCell respondsToSelector:@selector(customTableViewHeaderDelayShowOffset)]) {
                            appearOffset = [delayShowCell customTableViewHeaderDelayShowOffset];
                        }
                    }
                    
                    CGFloat sourceTableViewCellOriginY = [tableView rectForRowAtIndexPath:inPath].origin.y;
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
            UIView *contentView = [self __tableView:tableView customTableViewHeaderViewAtIndexPath:inPath];
            if (contentView) {
                //添加并展示view
                if (![[self.topFloatView subviews] containsObject:contentView]) {
                    [self.topFloatView addSubview:contentView];
                    [self layoutCustomHeaderViewForUITableView:tableView];
                }
            }
        }
    } else if (scrollDirection == ScrollDirectionDown) {
        
        NSMutableArray *hidedIndex = [NSMutableArray array];
        for (NSIndexPath *inPath in [self __indexPathsOfCustomHeaderViewInTableView:tableView]) {
            if (inPath.section < indexPath.section) {
                continue;
            } else if (inPath.section == indexPath.section) {
                if (inPath.row < indexPath.row) {
                    continue;
                } else if (inPath.row == indexPath.row) {
                    //------支持偏移量-开始-------
                    UITableViewCell *sourceTableViewCell = [tableView cellForRowAtIndexPath:inPath];
                    CGFloat disAppearOffset = 0;
                    if (sourceTableViewCell && [sourceTableViewCell conformsToProtocol:@protocol(CustomTableViewHeaderCellDelayShowProtocol)]) {
                        id<CustomTableViewHeaderCellDelayShowProtocol> delayShowCell = (id<CustomTableViewHeaderCellDelayShowProtocol>)sourceTableViewCell;
                        if ([sourceTableViewCell respondsToSelector:@selector(customTableViewHeaderDelayHideOffset)]) {
                            disAppearOffset = [delayShowCell customTableViewHeaderDelayHideOffset];
                        }
                    }
                    CGRect rect = [tableView rectForRowAtIndexPath:inPath];
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
            UIView *contentView = [self __tableView:tableView customTableViewHeaderViewAtIndexPath:inPath];
            if (contentView) {
                //消失
                if (self.topFloatView.superview && [[self.topFloatView subviews] containsObject:contentView]) {
                    [contentView removeFromSuperview];
                    [self layoutCustomHeaderViewForUITableView:tableView];
                }
            }
        }
    }
}

- (void)layoutCustomHeaderViewForUITableView:(UITableView *)tableView {
    if (!self.hostView) {
        return;
    }

    NSArray *subviews = [self.topFloatView subviews];
    if (subviews.count) {
        if (!self.topFloatView.superview) {
            [self.hostView addSubview:self.topFloatView];
            self.topFloatView.alpha = 1;
        }
        CGFloat sumHeight = 0;
        CGFloat maxWidth = 0;
        for (UIView *subview in [self.topFloatView subviews]) {
            subview.frame = CGRectMake(subview.frame.origin.x, sumHeight, subview.frame.size.width, subview.frame.size.height);
            sumHeight += subview.frame.size.height;
            maxWidth = subview.frame.size.width > maxWidth ? subview.frame.size.width : maxWidth;
        }
        self.topFloatView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y + tableView.contentInset.top, maxWidth, sumHeight);
    } else {
        if (self.topFloatView.superview) {
            self.topFloatView.alpha = 0;
            self.topFloatView.frame = CGRectZero;
            [self.topFloatView removeFromSuperview];
        }
    }
}

- (NSArray *)__indexPathsOfCustomHeaderViewInTableView:(UITableView *)tableView {
    NSArray *resultArr = nil;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(indexPathsOfCustomHeaderViewInTableView:)]) {
        resultArr = [self.dataSource indexPathsOfCustomHeaderViewInTableView:tableView];
    }
    return resultArr;
}

- (UIView *)__tableView:(UITableView *)tableView customTableViewHeaderViewAtIndexPath:(NSIndexPath *)indexPath {
    UIView *resultView = nil;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(tableView:customTableViewHeaderViewAtIndexPath:)]) {
        resultView = [self.dataSource tableView:tableView customTableViewHeaderViewAtIndexPath:indexPath];
    }
    return resultView;
}
@end
