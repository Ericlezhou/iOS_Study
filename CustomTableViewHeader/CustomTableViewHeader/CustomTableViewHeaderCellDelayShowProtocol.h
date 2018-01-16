//
//  CustomTableViewHeaderCellDelayShowProtocol.h
//  CustomTableViewHeader
//
//  Created by Eric on 2018/1/16.
//  Copyright © 2018年 nexus. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CustomTableViewHeaderCellDelayShowProtocol <NSObject>
@required
- (CGFloat)customTableViewHeaderDelayShowOffset;
- (CGFloat)customTableViewHeaderDelayHideOffset;
@end
