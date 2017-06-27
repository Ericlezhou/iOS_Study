//
//  QLCacheItem.m
//  live4iphone
//
//  Created by heloyue on 14-3-21.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import "QLCacheItem.h"

@implementation QLCacheItem
@synthesize cacheData = _cacheData;
@synthesize updateTimestamp  = _updateTimestamp;
@synthesize expires  = _expires;
@synthesize message  = _message;


+ (QLCacheItem *) itemWithData:(NSMutableArray *)data message:(NSString *)msg
{
    QLCacheItem *item = [[QLCacheItem alloc] init];
    item.cacheData = data;
    item.message = msg;
    
    return item ;
    
}

- (id)init
{
    self = [super init];
    if(self){
        self.cacheData = [[NSMutableArray alloc] init] ;
        self.message = [[NSString  alloc] init] ;
        self.expires = 0;
        self.updateTimestamp = 0.0 ;
        self.version = CacheVersion;
    }
    return self;
}



- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.cacheData forKey:@"cacheData"];
    [aCoder encodeObject:self.message   forKey:@"message"];
    [aCoder encodeInteger:self.expires forKey:@"expires"];
    [aCoder encodeDouble:self.updateTimestamp forKey:@"updateTimestamp"];
    [aCoder encodeObject:self.version forKey:@"version"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSString *theVersion = [aDecoder decodeObjectForKey:@"version"];
    if (![theVersion isEqualToString:CacheVersion]) {
        return nil;
    }
    
    if (self = [super init])
    {
        self.cacheData = [aDecoder decodeObjectForKey:@"cacheData"];
        self.message = [aDecoder decodeObjectForKey:@"message"];
        self.expires = [aDecoder decodeIntegerForKey:@"expires"];
        self.updateTimestamp = [aDecoder decodeDoubleForKey:@"updateTimestamp"];
        self.version = theVersion;
    }
    
    return self;
}




@end
