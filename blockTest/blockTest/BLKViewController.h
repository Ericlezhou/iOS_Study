//
//  BLKViewController.h
//  blockTest
//
//  Created by 周乐 on 16/2/28.
//  Copyright © 2016年 ericlezhou. All rights reserved.
//

#import "ViewController.h"

typedef void(^BLKBlock)();
@interface BLKViewController: UIViewController

-(instancetype)initWithCallBackBlcok:(BLKBlock)blcok;

@end
