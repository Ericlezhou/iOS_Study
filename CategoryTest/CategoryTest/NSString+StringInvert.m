//
//  NSString+StringInvert.m
//  CategoryTest
//
//  Created by 周乐 on 16/2/10.
//  Copyright © 2016年 ericlezhou. All rights reserved.
//

#import "NSString+StringInvert.h"

@implementation NSString (StringInvert)

-(NSString *)reversedString{
    
    
    NSMutableString *result = [NSMutableString stringWithCapacity:self.length];
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
                             options:(NSStringEnumerationReverse|NSStringEnumerationByComposedCharacterSequences)
                          usingBlock:^(NSString * substring, NSRange substringRange, NSRange enclosingRange, BOOL * stop) {
        [result appendString:substring];
    }];
    return  result;
}
@end
