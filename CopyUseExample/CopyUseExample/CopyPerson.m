//
//  CopyPerson.m
//  CopyUseExample
//
//  Created by Eric on 2018/2/11.
//  Copyright © 2018年 nexus. All rights reserved.
//

#import "CopyPerson.h"
@interface CopyPerson()
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSUInteger age;
@end

@implementation CopyPerson
- (id)copyWithZone:(NSZone *)zone {
    CopyPerson *anotherPerson = [[CopyPerson alloc] init];
    anotherPerson.name = self.name;
    anotherPerson.age = self.age;
    return anotherPerson;
}
@end
