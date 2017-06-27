//
//  ViewController.m
//  ArchiverDemo
//
//  Created by Eric on 2017/6/7.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import "ViewController.h"
#import "QLCacheItem.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *array = [NSMutableArray array];
    NSString *messageID = @"123";
    QLCacheItem * cItem = [QLCacheItem itemWithData:array message:messageID];
    NSData * dictData = [NSKeyedArchiver archivedDataWithRootObject:cItem];
    NSString *filePath = [[[self class] getMomentNewPath] stringByAppendingPathComponent:@"huhu.data"];
    [dictData writeToFile:filePath atomically:YES];
    
    QLCacheItem *readObj = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"");
}

+ (NSString *)getMomentNewPath
{
    static NSString * pathRet = nil;
    if ( !pathRet ) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        pathRet = (NSString *)[paths objectAtIndex:0];
    }
    NSString *path = [NSString stringWithFormat:@"%@/Application Support/Moment", pathRet];
    BOOL isDir=YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
