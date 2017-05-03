//
//  OrderItem.h
//  MRRDemo
//
//  Created by Eric on 2017/5/3.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderItem : NSObject
{
@public NSString *name;
}

- (id) initWithName:(NSString *)itemName;
@end
