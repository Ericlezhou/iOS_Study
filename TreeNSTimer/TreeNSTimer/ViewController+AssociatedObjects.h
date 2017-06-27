//
//  ViewController+AssociatedObjects.h
//  TreeNSTimer
//
//  Created by Eric on 2017/6/27.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (AssociatedObjects)
@property (assign, nonatomic) NSString *associatedObject_assign;
@property (strong, nonatomic) NSString *associatedObject_retain;
@property (copy,   nonatomic) NSString *associatedObject_copy;
@end
