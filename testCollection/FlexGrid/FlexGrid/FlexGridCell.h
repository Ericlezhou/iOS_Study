//
//  FlexGridCell.h
//  FlexGrid
//
//  Created by Eric on 16/10/28.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlexGridCell : UICollectionViewCell
@property (nonatomic, copy) NSString *lableTxt;

+ (CGSize)makeSizeWithTextStr:(NSString *)text;

@end
