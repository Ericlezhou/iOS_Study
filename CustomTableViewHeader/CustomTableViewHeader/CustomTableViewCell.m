//
//  CustomTableViewCell.m
//  CustomTableViewHeader
//
//  Created by Eric on 2018/1/15.
//  Copyright © 2018年 nexus. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _upView = [[UIView alloc] initWithFrame:CGRectZero];
        _upView.backgroundColor = [UIColor redColor];
        _downView = [[UIView alloc] initWithFrame:CGRectZero];
        _downView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_upView];
        [self.contentView addSubview:_downView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _upView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 0.5);
    _downView.frame = CGRectMake(0, self.frame.size.height * 0.5, self.frame.size.width, self.frame.size.height * 0.5);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGFloat)customTableViewHeaderAppearOffset {
    return self.frame.size.height * 0.5;
}

@end
