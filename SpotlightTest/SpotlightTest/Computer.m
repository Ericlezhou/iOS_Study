//
//  Computer.m
//  SpotlightTest
//
//  Created by 周乐 on 16/8/4.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "Computer.h"

@implementation Computer

- (NSString *)shortDescription{
    return [NSString stringWithFormat:@"(%@)(%@)",_company, _model];
}

- (NSString *)cpuDescroption{
    return [NSString stringWithFormat:@"(%@)(%@)",_cpuSpeed, _cpu];
}
@end
