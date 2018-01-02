//
//  CustomHeaderView.h
//  CustomTableViewHeader
//
//  Created by Eric on 2017/12/29.
//  Copyright © 2017年 nexus. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomHeaderView;
@protocol CustomHeaderViewProtocol <NSObject>
- (void)didClickCustomHeaderView:(CustomHeaderView *)headerView;
@end
@interface CustomHeaderView : UIView
@property (nonatomic, weak) id<CustomHeaderViewProtocol> delegate;
@end
