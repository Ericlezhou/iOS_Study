//
//  CustomTableViewCell.h
//  CustomTableViewHeader
//
//  Created by Eric on 2018/1/15.
//  Copyright © 2018年 nexus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewHeaderCellDelayShowProtocol.h"

@interface CustomTableViewCell : UITableViewCell <CustomTableViewHeaderCellDelayShowProtocol>
@property (nonatomic, strong) UIView *upView;
@property (nonatomic, strong) UIView *downView;
@end
