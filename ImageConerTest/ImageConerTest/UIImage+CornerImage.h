//
//  UIImage+CornerImage.h
//  CornerRadius
//
//  Created by 周乐 on 16/3/3.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CornerImage)
-(UIImage *)kt_drawRectWithRoundedCornerWithRadius:(CGFloat) radius withSize:(CGSize) size;
@end
