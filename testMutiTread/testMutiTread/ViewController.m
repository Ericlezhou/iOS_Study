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
