//
//  BLKViewController.m
//  blockTest
//
//  Created by 周乐 on 16/2/28.
//  Copyright © 2016年 ericlezhou. All rights reserved.
//

#import "BLKViewController.h"
#import "BLKView.h"
#import "UIAlertView+Blocks.h"
@interface BLKViewController()

@property (nonatomic,copy) BLKBlock callbackBlock;

@property (nonatomic, strong) BLKView* aview;
@property (nonatomic, strong) id model;


@end

@implementation BLKViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"viewdidAppear!");
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.title = @"BLKViewController";
    
    [[[UIAlertView alloc] initWithTitle:@"\"腾讯视频\"想访问您的相机"
                                message:@"需要使用相机来录制视频"
                       cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:nil]
                       otherButtonItems:[RIButtonItem itemWithLabel:@"去设置" action:^{
        if (@available(iOS 8.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Privacy&path=CAMERA&path=com.tencent.live4iphone.dev"]];
        }
    }] ,nil] show];
    
    
//    __weak __typeof(self) weakSelf = self;  //此处依然是为了避免对self的循环引用
//    self.aview = [[BLKView alloc] initWithFBBlcok:^(id inModel){     //这个block传入一个参数model用来回传，当点击了BLKView的button就会将model回传给控制器。这是一种设计模式
//        weakSelf.model = inModel;
//        if ([inModel isKindOfClass:[NSString class]]) {
//            weakSelf.title = (NSString *)inModel;
//        }
//
//    }];
//    self.aview.frame = self.view.frame;
//    [self.view addSubview:_aview];
//    self.aview.backgroundColor = [UIColor redColor];
    
    
}

-(instancetype)initWithCallBackBlcok:(BLKBlock) inBlcok{
    if (self = [super init]) {
        self.callbackBlock = inBlcok;
    }
    return  self;
}

-(void)dealloc{
    NSLog(@"dealloc ~~~~~~~");
}
@end
