//
//  ViewController.m
//  testMutiTread
//
//  Created by Eric on 2017/11/1.
//

#import "ViewController.h"

@interface ViewController (){
    dispatch_queue_t _backgroundQueue;
    NSMutableArray *_initArray;
}

@end

@implementation ViewController

-(void)awakeFromNib {
    [super awakeFromNib];
    _backgroundQueue = dispatch_queue_create("com.test.multithread", NULL);
    _initArray = @[@"1", @"2", @"3", @"4", @"5", @"6"].mutableCopy;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i = 0; i < 100000; i++) {
        if (i % 3 == 0) {
            dispatch_async(_backgroundQueue, ^{
                
                [self deleteSelfObject];
            });
        }else if(i % 2 == 0){
            dispatch_async(_backgroundQueue, ^{
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
//    @synchronized(_initArray) {
        NSString *addObj = [NSString stringWithFormat:@"%lu",_initArray.count+1];
        [_initArray addObject:addObj];
        NSLog(@"%@--addSelfObject func and array is %@", [NSThread currentThread], _initArray);
//    }
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


@end
