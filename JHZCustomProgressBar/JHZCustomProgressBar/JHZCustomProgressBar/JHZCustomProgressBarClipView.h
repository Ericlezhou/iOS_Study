//
//  JHZCustomProgressBarClipView.h
//  JHZCustomProgressBar
//
//  Created by Eric on 2018/5/13.
//  Copyright © 2018年 nexus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHZCustomProgressBarClipView : UIView
@property (nonatomic, assign) float clipProgress;
@property(nonatomic, strong, nullable) UIColor* clipProgressTintColor;
@property(nonatomic, strong, nullable) UIColor* clipTrackTintColor;
@property(nonatomic, strong, nullable) UIColor* clipTagColor;
@end
