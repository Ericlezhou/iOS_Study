//
//  Computer.h
//  SpotlightTest
//
//  Created by 周乐 on 16/8/4.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Computer : NSObject

@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *model;
@property (nonatomic, strong) NSString *productionStartYear;
@property (nonatomic, strong) NSString *cpu;
@property (nonatomic, strong) NSString *cpuSpeed;
@property (nonatomic, strong) NSString *ram;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, strong) NSString *maxScreenResolution;
@property (nonatomic, strong) UIImage *image;

- (NSString *)shortDescription;
- (NSString *)cpuDescroption;
@end
