//
//  QLFloatLayoutView.m
//  FloatView
//
//  Created by Eric on 2017/3/21.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import "QLFloatLayoutView.h"
@interface QLFloatLayoutView ()
{
    NSMutableArray *_viewStoreArrays;
}
@end
@implementation QLFloatLayoutView

CGFloat UIEdgeInsetsGetVerticalValue(UIEdgeInsets insets) {
    return insets.top + insets.bottom;
}

CGFloat UIEdgeInsetsGetHorizontalValue(UIEdgeInsets insets) {
    return insets.left + insets.right;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.minimumItemSize = CGSizeZero;
        self.maximumItemSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
        _viewStoreArrays = [NSMutableArray array];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [self layoutSubviewsWithSize:size shouldLayout:NO];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutSubviewsWithSize:self.bounds.size shouldLayout:YES];
    if (self.horizonAlign) {
        [self reLayoutForHorizonCenterAlginment];
    }
}

- (void)removeAllSubviews
{
    NSArray *viewsToRemove = [self subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    [_viewStoreArrays removeAllObjects];
}

- (void)reloadData
{
    [self removeAllSubviews];
    [self addViewsDependOnModels];
    [self setNeedsLayout];
}

- (void)addViewsDependOnModels
{
    NSUInteger subViewCount = 0;
    if (!_dataSource || ![_dataSource conformsToProtocol:@protocol(QLFloatLayoutViewDataSource)]) {
        NSLog(@"Exception");
        return;
    }
    
    subViewCount = [_dataSource numberOfItemsForFloatLayoutView:self];
    
    for (NSInteger i = 0, l = subViewCount; i < l; i++)
    {
        UIView *itemView = [_dataSource floatLayoutView:self itemViewForIndex:i];
        if (itemView)
        {
            UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
            [itemView addGestureRecognizer:rec];
            [self addSubview:itemView];
            [_viewStoreArrays addObject:itemView];
        }
    }

}
- (void)handleTapFrom:(UITapGestureRecognizer *)sender
{
    UIView *view = sender.view;
    NSUInteger index = [_viewStoreArrays indexOfObject:view];
    if (index != NSNotFound && _delegate &&  [_delegate respondsToSelector:@selector(floatLayoutView:didSelectItemViewAtIndex:)])
    {
        [_delegate floatLayoutView:self didSelectItemViewAtIndex:index];
    }
}



- (CGSize)layoutSubviewsWithSize:(CGSize)size shouldLayout:(BOOL)shouldLayout {
    NSArray<UIView *> *visibleItemViews = [self visibleSubviews];
    
    if (visibleItemViews.count == 0) {
        return CGSizeMake(UIEdgeInsetsGetHorizontalValue(self.padding), UIEdgeInsetsGetVerticalValue(self.padding));
    }
    
    CGPoint itemViewOrigin = CGPointMake(self.padding.left, self.padding.top);
    CGFloat currentRowMaxY = itemViewOrigin.y;
    
    for (NSInteger i = 0, l = visibleItemViews.count; i < l; i ++) {
        UIView *itemView = visibleItemViews[i];
        
        CGSize itemViewSize = [itemView sizeThatFits:CGSizeMake(self.maximumItemSize.width, self.maximumItemSize.height)];
        itemViewSize.width = fmaxf(self.minimumItemSize.width, itemViewSize.width);
        itemViewSize.height = fmaxf(self.minimumItemSize.height, itemViewSize.height);
        
        if (itemViewOrigin.x + self.itemMargins.left + itemViewSize.width > size.width - self.padding.right) {
            // 换行，左边第一个 item 是不考虑 itemMargins.left 的
            if (shouldLayout) {
                itemView.frame = CGRectMake(self.padding.left, currentRowMaxY + self.itemMargins.top, itemViewSize.width, itemViewSize.height);
            }
            
            itemViewOrigin.x = self.padding.left + itemViewSize.width + self.itemMargins.right;
            itemViewOrigin.y = currentRowMaxY;
        } else {
            // 当前行放得下
            if (shouldLayout) {
                itemView.frame = CGRectMake(itemViewOrigin.x + self.itemMargins.left, itemViewOrigin.y + self.itemMargins.top, itemViewSize.width, itemViewSize.height);
            }
            
            itemViewOrigin.x += UIEdgeInsetsGetHorizontalValue(self.itemMargins) + itemViewSize.width;
        }
        
        currentRowMaxY = fmaxf(currentRowMaxY, itemViewOrigin.y + UIEdgeInsetsGetVerticalValue(self.itemMargins) + itemViewSize.height);
    }
    
    // 最后一行不需要考虑 itemMarins.bottom，所以这里减掉
    currentRowMaxY -= self.itemMargins.bottom;
    
    CGSize resultSize = CGSizeMake(size.width, currentRowMaxY + self.padding.bottom);
    return resultSize;
}

- (void)reLayoutForHorizonCenterAlginment
{
    NSArray<UIView *> *visibleItemViews = [self visibleSubviews];
    if ([visibleItemViews count] == 0) {
        return;
    }
    //initialize
    NSMutableArray *tempArr = [NSMutableArray array];
    CGFloat originY = ((UIView *)[visibleItemViews firstObject]).center.y;
    [tempArr addObject:[visibleItemViews firstObject]];
    
    for (NSUInteger i = 1; i < visibleItemViews.count; i++) {
        UIView *view = visibleItemViews[i];
        if (view.center.y != originY) {
            [self horizonCenterAlignSubViews:tempArr];
            originY = view.center.y;
            [tempArr removeAllObjects];
        }
        [tempArr addObject:view];
        //last one
        if (i == visibleItemViews.count - 1) {
            [self horizonCenterAlignSubViews:tempArr];
        }
    }
}

- (void)horizonCenterAlignSubViews:(NSArray *)subViews
{
    if (subViews.count == 0) {
        return;
    }
    CGFloat viewSumW = 0;
    for (UIView *view in subViews) {
        viewSumW += view.frame.size.width;
    }
    
    viewSumW += (subViews.count - 1) * (self.itemMargins.left + self.itemMargins.right);
    
    CGFloat originX = ceilf((self.bounds.size.width - viewSumW) * 0.5);
    
    for (NSUInteger i = 0; i < subViews.count; i++) {
        UIView *view = subViews[i];
        view.frame = CGRectMake(originX, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
        originX += view.frame.size.width + self.itemMargins.left + self.itemMargins.right;
    }
    
}


- (NSArray<UIView *> *)visibleSubviews {
    NSMutableArray<UIView *> *visibleItemViews = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0, l = self.subviews.count; i < l; i++) {
        UIView *itemView = self.subviews[i];
        if (!itemView.hidden) {
            [visibleItemViews addObject:itemView];
        }
    }
    return visibleItemViews;
}


@end
