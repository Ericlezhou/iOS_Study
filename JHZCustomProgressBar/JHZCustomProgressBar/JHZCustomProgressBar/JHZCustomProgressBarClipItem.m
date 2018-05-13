//
//  JHZCustomProgressBarClipItem.m
//  JHZCustomProgressBar
//
//  Created by Eric on 2018/5/13.
//  Copyright © 2018年 nexus. All rights reserved.
//

#import "JHZCustomProgressBarClipItem.h"

@implementation JHZCustomProgressBarClipItem
- (instancetype)init {
    if (self = [super init]) {
        _clipStatus = JHZCustomProgressBarClipStatus_Finish;
        _clipProgressTintColor = [UIColor greenColor];
        _clipTrackTintColor = [UIColor grayColor];
        _clipTagColor = [UIColor redColor];
    }
    return self;
}
@end
