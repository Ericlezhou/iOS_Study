//
//  QLCacheItem.h
//  live4iphone
//
//  Created by heloyue on 14-3-21.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

#define     CacheVersion    @"v1.4"

@interface QLCacheItem : NSObject <NSCoding>
{
    NSMutableArray *            _cacheData;                 //cache 数据
    
    NSTimeInterval              _updateTimestamp;           //最近更新时间
    
    NSInteger                   _expires;                   //过期时长，单位为秒，0表示永不过期
    
    NSString *                  _message;                   //标识属于哪个message id
    
    NSString    *               _version;                   //缓存版本，用于控制升级
}

@property   (nonatomic, strong)     NSMutableArray *            cacheData;
@property   (nonatomic, assign)     NSTimeInterval              updateTimestamp;
@property   (nonatomic, assign)     NSInteger                   expires;
@property   (nonatomic, strong)     NSString    *               message;
@property   (nonatomic, strong)     NSString    *               version;


+ (QLCacheItem *)itemWithData:(NSMutableArray *)data message:(NSString *)msg;

@end
