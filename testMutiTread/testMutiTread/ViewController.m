//
//  ViewController.m
//  testMutiTread
//
//  Created by Eric on 2017/11/1.
//

#import "ViewController.h"

@interface TTObj : NSObject
@end
@implementation TTObj
-(void)dealloc {
    NSLog(@"TTObj %@ dealloc with %@",self, [NSThread currentThread]);
}
@end

@interface ViewController (){
    dispatch_queue_t _backgroundQueue;
    dispatch_queue_t _backgroundQueueV2;
    NSMutableArray *_initArray;
}

@end

@implementation ViewController

-(void)awakeFromNib {
    [super awakeFromNib];
    _backgroundQueue = dispatch_queue_create("com.test.multithread", NULL);
    _backgroundQueueV2 = dispatch_queue_create("com.test.multithreadV2", NULL);
    _initArray = @[@"1", @"2", @"3", @"4", @"5", @"6"].mutableCopy;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //test 1   !!!! bad example
    /*
    dispatch_sync(_backgroundQueue, ^{
        NSLog(@"test 1.0 %@", [NSThread isMainThread] ? @"main thread" : @"not main thread");
        if ([NSThread isMainThread]) {
            dispatch_sync(_backgroundQueue, ^{
                NSLog(@"test 1.1 %@", [NSThread isMainThread] ? @"main thread" : @"not main thread");
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"test 1.2 %@", [NSThread isMainThread] ? @"main thread" : @"not main thread");
            });
        }
    });
     */
    
    //test 2
    
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"test 2.0 %@", [NSThread isMainThread] ? @"main thread" : @"not main thread");
//        if ([NSThread isMainThread]) {
//            dispatch_sync(_backgroundQueue, ^{
//                NSLog(@"test 2.1 %@", [NSThread isMainThread] ? @"main thread" : @"not main thread");
//            });
//        } else {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"test 2.2 %@", [NSThread isMainThread] ? @"main thread" : @"not main thread");
//            });
//        }
//    });
    
    
    //test 3  common example
//    dispatch_async(_backgroundQueue, ^{
//        if ([NSThread isMainThread]) {
//            dispatch_sync(_backgroundQueue, ^{
//                NSLog(@"test 3.1 %@", [NSThread isMainThread] ? @"main thread" : @"not main thread");
//            });
//        } else {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"test3.2 %@", [NSThread isMainThread] ? @"main thread" : @"not main thread");
//            });
//        }
//    });
    
    
    
    //test 4  dispatch_queue_set_specific && dispatch_get_specific
//    static void *queueKey1 = "queueKey1";
//    dispatch_queue_set_specific(dispatch_get_main_queue(), queueKey1, &queueKey1, NULL);
//    dispatch_sync(_backgroundQueue, ^{
//        void *flag = dispatch_get_specific(queueKey1);
//        if (flag) {
//            dispatch_sync(_backgroundQueue, ^{
//                NSLog(@"test 4.1 %@", [NSThread isMainThread] ? @"main thread" : @"not main thread");
//            });
//        } else {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"test 4.2 %@", [NSThread isMainThread] ? @"main thread" : @"not main thread");
//            });
//        }
//    });
    
    //test 5  dispatch_queue_get_label
    dispatch_sync(_backgroundQueue, ^{
        if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {
            dispatch_sync(_backgroundQueue, ^{
                NSLog(@"test 5.1 %@", [NSThread isMainThread] ? @"main thread" : @"not main thread");
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"test 5.2 %@", [NSThread isMainThread] ? @"main thread" : @"not main thread");
            });
        }
    });
    
    
    /*
    for (int i = 0; i < 20; i++) {
        if (i % 3 == 0) {
            dispatch_async(_backgroundQueue, ^{
                [self deleteSelfObject];
            });
        }else if(i % 2 == 0){
//            dispatch_async(_backgroundQueue, ^{
//                [self addSelfObject];
//            });
            dispatch_async(_backgroundQueueV2, ^{
                [self addSelfObject];
            });
        }else if (i % 7 == 0){
            @synchronized(_initArray) {
            for (id obj in _initArray) {
                NSLog(@"%@", obj);
            }
            NSLog(@"%@--addSelfObject func and array is %@", [NSThread currentThread], _initArray);
            }
        }
        
    }
     */
}


- (void)addSelfObject {
    @synchronized(_initArray) {
//        NSString *addObj = [NSString stringWithFormat:@"%lu",_initArray.count+1];
//        [_initArray addObject:addObj];
        TTObj *oo = [TTObj new];
        [_initArray addObject:oo];
        NSLog(@"%@--addSelfObject func and array is %@", [NSThread currentThread], _initArray);
    }
}

- (void)deleteSelfObject {
    @synchronized(_initArray) {
        if (_initArray.count) {
            [_initArray removeLastObject];
        }
        NSLog(@"%@--deleteSelfObject func and array is %@", [NSThread currentThread] , _initArray);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


/*
 2017-11-13
 关于多线程中NSObject的dealloc的时机的结论：一个对象的dealloc方法会在该对象的引用计数变为0的线程被调用.
 参考 http://www.blogs8.cn/posts/WBr19b2
*/

@end
