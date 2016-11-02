//
//  FlexGridCell.m
//  FlexGrid
//
//  Created by Eric on 16/10/28.
//  Copyright © 2016年 Eric. All rights reserved.
//

#define kButtonL 52
#define kFontSize 14

#import "FlexGridCell.h"
@interface FlexGridCell(){
    UILabel* _button;
}
@end

@implementation FlexGridCell

+(CGSize)makeSizeWithTextStr:(NSString *)text{
    CGSize targetSize = CGSizeZero;
    if (!text.length) {
        return  targetSize;
    }
    
    UIFont *useFont = [UIFont systemFontOfSize:kFontSize];
//    CGFloat singleLineHight = useFont.ascender - useFont.descender + 1;
    CGRect rect = [text boundingRectWithSize:CGSizeMake(2 * kButtonL, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:useFont} context:nil];
    //单个
    if (rect.size.width < kButtonL ) {
        targetSize = CGSizeMake(kButtonL, kButtonL);
    }else if (rect.size.width >= kButtonL){
    //两个
        targetSize = CGSizeMake(kButtonL * 2, kButtonL);
    }
    return targetSize;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _button = [[UILabel alloc] initWithFrame:self.bounds];
        _button.font = [UIFont systemFontOfSize:kFontSize];
        _button.numberOfLines = 2;
        _button.textAlignment = NSTextAlignmentCenter;
        _button.textColor = [UIColor blackColor];
        _button.lineBreakMode = NSLineBreakByTruncatingTail;
        _button.backgroundColor = [UIColor greenColor];
        [self addSubview:_button];
    }
    return self;
}

- (void)setObj:(NSString *)text{
    [_button setText:text];
    [_button setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _button.frame = self.bounds;
    
    CGRect rect = [_button.text boundingRectWithSize:CGSizeMake(2 * kButtonL, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_button.font} context:nil];
        CGFloat singleLineHight = _button.font.ascender - _button.font.descender + 1;
    //单个
    if (rect.size.height > singleLineHight * 1.5) {
        _button.textAlignment = NSTextAlignmentLeft;
    }else {
        //两个
        _button.textAlignment = NSTextAlignmentCenter;
    }

}

@end
