//
//  FlexGridCell.m
//  FlexGrid
//
//  Created by Eric on 16/10/28.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "FlexGridCell.h"
@interface FlexGridCell(){
    UIButton *_button;
}
@end

@implementation FlexGridCell

+(CGSize)makeSizeWithTextStr:(NSString *)text{
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_button];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

@end
