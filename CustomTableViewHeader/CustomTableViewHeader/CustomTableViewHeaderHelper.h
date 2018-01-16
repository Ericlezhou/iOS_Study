//
//  CustomTableViewHeaderHelper.h
//  CustomTableViewHeader
//
//  Created by Eric on 2018/1/16.
//  Copyright © 2018年 nexus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CustomTableViewHeaderCellDelayShowProtocol.h"

@protocol CustomTableViewHeaderHelperDataSource <NSObject>
- (NSArray *)indexPathsOfCustomHeaderViewInTableView:(UITableView *)tableView;
- (UIView *)tableView:(UITableView *)tableView customTableViewHeaderViewAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface CustomTableViewHeaderHelper : NSObject
@property (nonatomic, weak) id<CustomTableViewHeaderHelperDataSource> dataSource;
@property (nonatomic, strong) UIView *topFloatView;
- (instancetype)initWithTableViewHostView:(UIView *)hostView;
- (void)tableViewDidScroll:(UITableView *)tableView;
@end
