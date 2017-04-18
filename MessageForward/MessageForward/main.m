//
//  main.m
//  MessageForward
//
//  Created by Eric on 2017/4/17.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hydrogen.h"
#import "Atom+Helper.h"
#import <objc/runtime.h>
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, Atom World!");
        Hydrogen *h = [[Hydrogen alloc] initWithNeutrons:1];
        
        /*
            dynamic add class method
         */
        [h bomb];               //resolveInstanceMethod
        [Hydrogen classBomb];   //resolveClassMethod
        

        /*
            test fast forward
         */
        NSString *str = [h factoid];
        NSLog(@"%@",str);
        
        /*
            test normal forward
         */
        [h performSelector:@selector(innerValue)];
        
        /*
            test object_getClass vs. [obj class]
         */
        NSLog(@"----------------------");
        Hydrogen *hh = [Hydrogen new];
        
        /*
         
         typedef struct objc_object {
            Class isa;
         } *id;
         
         */
        
        //the following two methods both return the hh's class object , objc_object's isa pointer
        Class clsObj = object_getClass(hh);
        Class clsObj2 = [hh class];    //Returns the class object for the receiver’s class.
        assert(clsObj == clsObj2);
        NSLog(@"结论：当obj为实例变量时，object_getClass(obj)与[obj class]输出结果一直，均获得isa指针，即指向类对象的指针。");
        
        /*
         
         typedef struct objc_class *Class;
         struct objc_class {
            Class isa;
            Class super_class;
         };
         
         */
        //the following two methods return the different result.
        //[clsObj class] is equal to clsObj, however, object_getClass(clsObj) return the objc_class's isa pointer
        Class cls = [clsObj class];   //Returns the class object. Refer to a class only by its name when it is the receiver of a message. In all other cases, the class object must be obtained through this or a similar method.
        Class cls2 = object_getClass(clsObj);
        assert(cls != cls2);
        assert(cls == clsObj);
        NSLog(@"结论：当obj为类对象时，object_getClass(obj)返回类对象中的isa指针，即指向元类对象的指针；[obj class]返回的则是其本身。");
        NSLog(@"object_getClass(obj)返回的是obj中的isa指针，而[obj class]则分两种情况：一是当obj为实例对象时，[obj class]中class是实例方法：- (Class)class，返回的obj对象中的isa指针；二是当obj为类对象（包括元类和根类以及根元类）时，调用的是类方法：+ (Class)class，返回的结果为其本身。");
    }
    return 0;
}
