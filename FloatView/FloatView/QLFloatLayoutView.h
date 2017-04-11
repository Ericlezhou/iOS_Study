//
//  QLFloatLayoutView.h
//  FloatView
//
//  Created by Eric on 2017/3/21.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QLFloatLayoutView;

@protocol QLFloatLayoutViewDelegate <NSObject>

@optional
- (void)floatLayoutView:(QLFloatLayoutView *) floatLayoutView didSelectItemViewAtIndex:(NSUInteger) index;

@end

@protocol QLFloatLayoutViewDataSource <NSObject>
@required
- (NSInteger)numberOfItemsForFloatLayoutView:(QLFloatLayoutView *) floatLayoutView;
- (UIView *_Nullable)floatLayoutView:(QLFloatLayoutView *) floatLayoutView itemViewForIndex:(NSUInteger) index;

@end



/**
 *  做类似 css 里的 float:left 的布局，自行使用 addSubview: 将子 View 添加进来即可。
 */
@interface QLFloatLayoutView : UIView

@property (nonatomic, weak, nullable) id <QLFloatLayoutViewDataSource> dataSource;
@property (nonatomic, weak, nullable) id <QLFloatLayoutViewDelegate> delegate;


/**
 *  QMUIFloatLayoutView 内部的间距，默认为 UIEdgeInsetsZero
 */
@property(nonatomic, assign) UIEdgeInsets padding;

/**
 *  item 的最小宽高，默认为 CGSizeZero，也即不限制。
 */
@property(nonatomic, assign) CGSize minimumItemSize;

/**
 *  item 的最大宽高，默认为 CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)，也即不限制
 */
@property(nonatomic, assign) CGSize maximumItemSize;

/**
 *  item 之间的间距，默认为 UIEdgeInsetsZero。
 *
 *  @warning 上、下、左、右四个边缘的 item 布局时不会考虑 itemMargins.left/bottom/left/right。
 */
@property(nonatomic, assign) UIEdgeInsets itemMargins;

@property (nonatomic, assign) BOOL horizonAlign;

- (void)reloadData;
@end
