//
//  main.m
//  test
//
//  Created by Eric on 16/4/14.
//  Copyright © 2016年 Eric. All rights reserved.
//
#define UNIVERSAL_LINK_HOST_A @"m.v.qq.com"
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
#pragma clang diagnostic ignored "-Wunreachable-code"
        //GCD vs NSTimer
        //get a queue
        NSUInteger i = 10000;
        while (i > 0) {
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_UNSPECIFIED, 0), ^{
                NSLog(@"______%ld",i);
            });
            NSLog(@"%ld_____outer",i);
            i--;
        }
        
        
        return 0;
        
        
        //测试数组枚举
        NSArray *arr = @[@1, @2, @3, @4, @5];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSInteger num = [obj intValue];
            
            if (num == 3) {
                return ;
            }
            NSLog(@"%ld",(long)num);
            
        }];
        
        NSLog(@"-------\n\n");
        
        NSEnumerator *enumerator = [arr objectEnumerator];
        id obj;
        while (obj = [enumerator nextObject]) {
            
            NSInteger num = [obj intValue];
            
//            if (num == 3) {
//                continue; // Skip this object，
//            }
            
            if (num == 4) {
                break; // Stop enumerating
            }
            NSLog(@"%ld",(long)num);
            
        }
        
        
        NSLog(@"-------\n\n");
        
        //检测版本
        NSString *one = @"5.0";
        NSString *curr = @"10.1";
        NSComparisonResult result = [one localizedStandardCompare:curr];
        //{NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending};
        if (result == NSOrderedAscending) {
            NSLog(@"NSOrderedAscending");
        }else if(result == NSOrderedSame){
            NSLog(@"NSOrderedSame");
        }else if(result == NSOrderedDescending){
            NSLog(@"NSOrderedDescending");
        }
        
        return 0;
        
        
        int a = 23;
        if (a>1) {
            NSLog(@"111");
        }else if(a > 2)
        {
            NSLog(@"222");
        }
        
        
        
        
        
        
        
        NSLog(@"--------------------------------------------");
        // insert code here...
        /*
         http://m.v.qq.com/cover/9/9s2mx37jzpr7bho.html
         http://m.v.qq.com/cover/9/9s2mx37jzpr7bho.html?vid=h002077iore
         http://m.v.qq.com/cover/9/9s2mx37jzpr7bho/b0020fxyox4.html
         http://m.v.qq.com/page/b/x/4/b0020fxyox4.html
         http://m.v.qq.com/play.html?vid=b0020fxyox4
         http://m.v.qq.com/play.html?cid=9s2mx37jzpr7bho
         http://m.v.qq.com/play.html?columnid=306
         http://m.v.qq.com/play/play.html?xxx(同上)
         http://m.v.qq.com/pgm/e****3re
         http://m.v.qq.com/live.html?pid=***
         */

        NSURL *url = [NSURL URLWithString:@"v.qq.com/live/p/topic/2/index.html"];
//        NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
//        NSString *host = components.host;
        NSString *urlStr = url.description;
        
        NSString *lid = nil;   //columnID
        NSString *cid = nil;   //15位
        NSString *vid = nil;   //11位
        NSString *pid = nil;
        NSString *whymePid = nil;
        NSString *whymeStreamStyle = nil;
        NSError *error0 = NULL;
        NSError *error1 = NULL;
        NSError *error2 = NULL;
        NSError *error3 = NULL;
        //cover/page case
        NSRegularExpression *regex0 = [NSRegularExpression
                                       regularExpressionWithPattern:@"v.qq.com/(cover|page)/.+"
                                       options:NSRegularExpressionCaseInsensitive
                                       error:&error0];
        //play case
        NSRegularExpression *regex1= [NSRegularExpression
                                      regularExpressionWithPattern:@"v.qq.com/(play|play/play).+"
                                      options:NSRegularExpressionCaseInsensitive
                                      error:&error1];
        //pgm/live case
        NSRegularExpression *regex2= [NSRegularExpression
                                      regularExpressionWithPattern:@"v.qq.com/(pgm/|live).+"
                                      options:0
                                      error:&error2];
        //whyme
        NSRegularExpression *regex3 = [NSRegularExpression
                                       regularExpressionWithPattern:@"v.qq.com/whyme/.+"
                                       options:0
                                       error:&error3];
        
        NSTextCheckingResult *match0 = [regex0 firstMatchInString:urlStr options:0 range:NSMakeRange(0, urlStr.length)];
        NSTextCheckingResult *match1 = [regex1 firstMatchInString:urlStr options:0 range:NSMakeRange(0, urlStr.length)];
        NSTextCheckingResult *match2 = [regex2 firstMatchInString:urlStr options:0 range:NSMakeRange(0, urlStr.length)];
        NSTextCheckingResult *match3 = [regex3 firstMatchInString:urlStr options:0 range:NSMakeRange(0, urlStr.length)];
        if (match0) {
            NSRange range0 = [urlStr rangeOfString:@"[a-z0-9]{15}" options:NSRegularExpressionSearch];
            if (range0.location != NSNotFound) {
                cid = [urlStr substringWithRange:range0];
                NSMutableString *tmpStr = [NSMutableString stringWithString:urlStr];
                [tmpStr deleteCharactersInRange:range0];
                urlStr = tmpStr;
            }
            NSRange range1 = [urlStr rangeOfString:@"[a-z0-9]{11}" options:NSRegularExpressionSearch];
            if (range1.location != NSNotFound) {
                vid = [urlStr substringWithRange:range1];
            }
        }else if (match1){
            NSRange range0 = [urlStr rangeOfString:@"cid=[a-z0-9]{15}" options:NSRegularExpressionSearch];
            if (range0.location != NSNotFound) {
                cid = [urlStr substringWithRange:range0];
                cid = [cid substringFromIndex:4];
            }
            NSRange range1 = [urlStr rangeOfString:@"vid=[a-z0-9]{11}" options:NSRegularExpressionSearch];
            if (range1.location != NSNotFound) {
                vid = [urlStr substringWithRange:range1];
                vid = [vid substringFromIndex:4];
            }
            NSRange range2 = [urlStr rangeOfString:@"columnid=[a-z0-9]+$" options:NSRegularExpressionSearch];
            if (range2.location != NSNotFound) {
                lid = [urlStr substringWithRange:range2];
                lid = [lid substringFromIndex:9];
            }
        }else if (match2){
            NSRange range0 = [urlStr rangeOfString:@"pgm/[a-z0-9]+" options:NSRegularExpressionSearch];
            NSRange range1 = [urlStr rangeOfString:@"pid=[a-z0-9]+" options:NSRegularExpressionSearch];
            NSRange range2 = [urlStr rangeOfString:@"live/p/topic/[a-z0-9]+" options:NSRegularExpressionSearch];
            if (range0.location != NSNotFound) {
                pid = [urlStr substringWithRange:NSMakeRange(range0.location + 4, range0.length - 4)];
            }else if (range1.location != NSNotFound){
                pid = [urlStr substringWithRange:NSMakeRange(range1.location + 4, range1.length - 4)];
            }else if (range2.location != NSNotFound){
                pid = [urlStr substringWithRange:NSMakeRange(range2.location + 13, range2.length - 13)];
            }
        }else if (match3){
            NSRange range0 = [urlStr rangeOfString:@"pid=[a-z0-9]+" options:NSRegularExpressionSearch];
            NSRange range1 = [urlStr rangeOfString:@"&streamstyle=[01]{1}" options:NSRegularExpressionSearch];
            if (range0.location != NSNotFound) {
                whymePid = [urlStr substringWithRange:NSMakeRange(range0.location + 4, range0.length - 4)];
            }
            if (range1.location != NSNotFound) {
                whymeStreamStyle = [urlStr substringWithRange:NSMakeRange(range1.location + 13, range1.length - 13)];;
            }else{
                whymeStreamStyle = @"1";
            }
        }
        // http://m.v.qq.com/whyme/index.html?pid=xxx&streamstyle=xxx
        
        BOOL valid = lid.length || cid.length || vid.length;
        if (valid) {   //点播
            NSString *newLid = lid.length ? [NSString stringWithFormat:@"lid=%@&", lid] : @"";
            NSString *newCid = cid.length ? [NSString stringWithFormat:@"cid=%@&", cid] : @"";
            NSString *newVid = vid.length ? [NSString stringWithFormat:@"vid=%@&", vid] : @"";
            NSString *actionURL= [NSString stringWithFormat:@"txvideo://v.qq.com/VideoDetailActivity?%@%@%@isAutoPlay=1", newLid, newCid, newVid];
            NSLog(@"%@",actionURL);
        }
        if (pid.length) {    //直播
            NSString *actionURL2 = [NSString stringWithFormat:@"txvideo://v.qq.com/TencentLiveActivity?pid=%@&isAutoPlay=1", pid];
            NSLog(@"%@",actionURL2);
        }
        if (whymeStreamStyle.length && whymePid.length) {   //whyme 直播
            NSString *actionURL = [NSString stringWithFormat:@"txvideo://v.qq.com/TencentLiveActivity?pid=%@&isFullScreen=1&style=1&streamStyle=%@", whymePid, whymeStreamStyle];
            NSLog(@"%@",actionURL);
        }
        
    }
    
    
    
    
    
    return 0;
}



