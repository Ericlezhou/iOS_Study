//
//  main.m
//  CategoryTest
//
//  Created by 周乐 on 16/2/10.
//  Copyright © 2016年 ericlezhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+StringInvert.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        //char * /const char *和NSString之间的转化
        char * filename = "hello world";
        NSString *nsfilename = [NSString stringWithUTF8String:filename];
        NSLog(@"%@",nsfilename);
        const char * fileback = [nsfilename UTF8String];//由NSString转换回来的char字符串是常量字符串指针const char*，需加上const
        printf("%s\n",fileback);
        
        NSLog(@"%@",[nsfilename reversedString]);
        
        
        
        NSString *myString = @"abcdefghijklmnopqrstuvwxyz";
        NSMutableString *reversedString = [NSMutableString stringWithCapacity:[myString length]];
        
        [myString enumerateSubstringsInRange:NSMakeRange(0,[myString length])
                                     options:(NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences)
                                  usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                      [reversedString appendString:substring];
                                  }];
        
    }
    return 0;
}


