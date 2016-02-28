//
//  BLKView.h
//  blockTest
//
//  Created by Eric on 16/2/28.
//  Copyright © 2016年 ericlezhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FeedbackBlock)(id model) ;

@interface BLKView : UIView

-(instancetype) initWithFBBlcok:(FeedbackBlock)inBlock;
@end
