//
//  JHZCustomProgressBarClipItem.h
//  JHZCustomProgressBar
//
//  Created by Eric on 2018/5/13.
//  Copyright © 2018年 nexus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, JHZCustomProgressBarClipStatus) {
    JHZCustomProgressBarClipStatus_Finish = 0,
    JHZCustomProgressBarClipStatus_Processing,
};

@interface JHZCustomProgressBarClipItem : NSObject
@property(nonatomic, assign) JHZCustomProgressBarClipStatus clipStatus;
@property (nonatomic, assign) float startProgress;
@property (nonatomic, assign) float endProgress;
@property(nonatomic, strong, nullable) UIColor* clipProgressTintColor;
@property(nonatomic, strong, nullable) UIColor* clipTrackTintColor;
@property(nonatomic, strong, nullable) UIColor* clipTagColor;
@end
