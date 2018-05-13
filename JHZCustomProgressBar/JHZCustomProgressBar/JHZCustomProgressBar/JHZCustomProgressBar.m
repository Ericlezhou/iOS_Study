//
//  JHZCustomProgressBar.m
//  JHZCustomProgressBar
//
//  Created by Eric on 2018/5/11.
//  Copyright © 2018年 nexus. All rights reserved.
//

#import "JHZCustomProgressBar.h"
#import "JHZCustomProgressBarClipItem.h"

@implementation JHZCustomProgressBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _progress = 0;
        _progressTintColor = [UIColor greenColor];
        _trackTintColor = [UIColor grayColor];
        _tagColor = [UIColor redColor];
    }
    return self;
}

- (void)setProgress:(float)progress {
    _progress = progress;
    [self setNeedsLayout];
}

- (NSArray<JHZCustomProgressBarClipItem *> *)arrayOfFinishedClipItems {
    NSMutableArray *arr = [NSMutableArray array];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(progressArrayOfClipTagsForJHZCustomProgressBar:)]) {
        NSArray <NSNumber *>*clipProgressArray = [self.dataSource progressArrayOfClipTagsForJHZCustomProgressBar:self];
        NSArray *sortedClipProgressArray = [clipProgressArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSComparisonResult result = [obj1 compare:obj2]; //升序
            return result;
        }];
        NSNumber *lastFloatObj = [sortedClipProgressArray firstObject];
        if (lastFloatObj) {
            for (NSUInteger index = 0; index < sortedClipProgressArray.count; index++) {
                NSNumber *floatObj = [sortedClipProgressArray objectAtIndex:index];
                JHZCustomProgressBarClipItem *clipItem = [[JHZCustomProgressBarClipItem alloc] init];
                clipItem.clipStatus = JHZCustomProgressBarClipStatus_Finish;
                if (index == 0) {
                    clipItem.startProgress = 0;
                    clipItem.endProgress = [floatObj floatValue];
                } else {
                    clipItem.startProgress = [lastFloatObj floatValue];
                    clipItem.endProgress = [floatObj floatValue];
                }
                [arr addObject:clipItem];
                lastFloatObj = floatObj;
            }
        }
    }
    return arr;
}

- (NSArray<JHZCustomProgressBarClipItem *> *)arrayOfClipItems {
    NSMutableArray<JHZCustomProgressBarClipItem *> *clipItems = [NSMutableArray array];
    JHZCustomProgressBarClipItem *lastClipedItem = [[self arrayOfFinishedClipItems] lastObject];
    if (lastClipedItem) {
        if (self.progress > lastClipedItem.endProgress) {
            JHZCustomProgressBarClipItem *processItem = [JHZCustomProgressBarClipItem new];
            processItem.clipStatus = JHZCustomProgressBarClipStatus_Processing;
            processItem.startProgress = lastClipedItem.endProgress;
            processItem.activeProgress = self.progress;
            [clipItems addObjectsFromArray:[self arrayOfFinishedClipItems]];
            [clipItems addObject:processItem];
        }
    }else{
        JHZCustomProgressBarClipItem *processItem = [JHZCustomProgressBarClipItem new];
        processItem.clipStatus = JHZCustomProgressBarClipStatus_Processing;
        processItem.startProgress = 0;
        processItem.activeProgress = self.progress;
        [clipItems addObject:processItem];
    }
    return clipItems;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}



@end
