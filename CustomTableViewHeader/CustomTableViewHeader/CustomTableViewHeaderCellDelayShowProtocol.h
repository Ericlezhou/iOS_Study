//
//  CustomTableViewHeaderCellDelayShowProtocol.h
//  CustomTableViewHeader
//
//  Created by Eric on 2018/1/16.
//  Copyright © 2018年 nexus. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CustomTableViewHeaderCellDelayShowProtocol <NSObject>
@optional
- (CGFloat)customTableViewHeaderDelayShowOffset;
- (CGFloat)customTableViewHeaderDelayHideOffset;
@end
