//
//  CustomHeaderView.m
//  CustomTableViewHeader
//
//  Created by Eric on 2017/12/29.
//  Copyright © 2017年 nexus. All rights reserved.
//

#import "CustomHeaderView.h"
@interface CustomHeaderView()
@property (nonatomic, strong) UITapGestureRecognizer *headerViewClickGesture;
@end

@implementation CustomHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        _headerViewClickGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewClicked:)];
        [self addGestureRecognizer:_headerViewClickGesture];
    }
    return self;
}

- (void)headerViewClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickCustomHeaderView:)]) {
        [self.delegate didClickCustomHeaderView:self];
    }
}
@end
