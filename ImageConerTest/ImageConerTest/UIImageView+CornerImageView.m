//
//  UIImageView+CornerImageView.m
//  CornerRadius
//
//  Created by 周乐 on 16/3/3.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "UIImage+CornerImage.h"
#import "UIImageView+CornerImageView.h"

@implementation UIImageView (CornerImageView)

- (void) kt_addConer:(CGFloat) radius{
    self.image = [self.image kt_drawRectWithRoundedCornerWithRadius:radius withSize:self.bounds.size];
}

@end
