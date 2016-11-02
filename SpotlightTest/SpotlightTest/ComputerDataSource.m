//
//  ComputerDataSource.m
//  SpotlightTest
//
//  Created by Eric on 16/8/4.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "ComputerDataSource.h"
#import "Computer.h"
@interface ComputerDataSource(){
    
}
@end

@implementation ComputerDataSource

-(instancetype)init{
    if (self = [super init]) {
        _computers = [[NSMutableArray alloc] init];
        NSBundle *bundle = [NSBundle mainBundle];
        NSURL *plistUrl = [bundle URLForResource:@"Computers" withExtension:@"plist"];
        if (plistUrl) {
            NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:plistUrl];
            if ([dic.allKeys containsObject:@"items"]) {
                NSArray *computerSpecs = dic[@"items"];
                if (computerSpecs.count) {
                    for (id obj in computerSpecs) {
                        if ([obj isKindOfClass:[NSDictionary class]]) {
                            NSDictionary * propertyDic = (NSDictionary *)obj;
                            Computer *cc = [[Computer alloc] init];
                            cc.company = [propertyDic objectForKey:@"company"];
                            cc.model = [propertyDic objectForKey:@"model"];
                            cc.productionStartYear = [propertyDic objectForKey:@"productionStartYear"];
                            cc.cpu = [propertyDic objectForKey:@"cpu"];
                            cc.cpuSpeed = [propertyDic objectForKey:@"cpuSpeed"];
                            cc.ram = [propertyDic objectForKey:@"ram"];
                            cc.color = [propertyDic objectForKey:@"color"];
                            cc.maxScreenResolution = [propertyDic objectForKey:@"maxScreenResolution"];
                            NSString *imgUrl = [bundle pathForResource:[propertyDic objectForKey:@"image"] ofType:nil];
                            UIImage *img = [UIImage imageWithContentsOfFile:imgUrl];
                            cc.image = img;
                            [_computers addObject:cc];
                        }
                    }
                    
                }
            }
        }
    }
    return self;
}




@end
