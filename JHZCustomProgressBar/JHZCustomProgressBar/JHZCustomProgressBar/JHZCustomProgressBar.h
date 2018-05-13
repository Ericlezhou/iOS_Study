//
//  JHZCustomProgressBar.h
//  JHZCustomProgressBar
//
//  Created by Eric on 2018/5/11.
//  Copyright © 2018年 nexus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class JHZCustomProgressBar;
@protocol JHZCustomProgressBarDataSource <NSObject>
//NSNumber类型的数组集合
- (NSArray <NSNumber *>*_Nullable)progressArrayOfClipTagsForJHZCustomProgressBar:(JHZCustomProgressBar *)progressBar;
@end

@interface JHZCustomProgressBar : UIView
@property (nonatomic, assign) float progress;
@property(nonatomic, strong, nullable) UIColor* progressTintColor;
@property(nonatomic, strong, nullable) UIColor* trackTintColor;
@property(nonatomic, strong, nullable) UIColor* tagColor;
@property(nonatomic, strong, nullable) id<JHZCustomProgressBarDataSource> dataSource;
@end
