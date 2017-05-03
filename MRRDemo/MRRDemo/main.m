//
//  main.m
//  MRRDemo
//
//  Created by Eric on 2017/5/3.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderEntry.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
         // Create an OrderEntry object for manual release
        NSString *orderId = [[NSString alloc] initWithString:@"A1"];
        OrderEntry *entry = [[OrderEntry alloc] initWithId:orderId];
        // Release orderId (retained by OrderEntry, so object not deallocated!)
        [orderId release];
        NSLog(@"New order, ID = %@, item: %@", entry->orderId, entry->item->name);
        // Must manually release OrderEntry!
        [entry release];
        // Create an autorelease OrderEntry object, released at the end of
        // the autorelease pool block
        OrderEntry *autoEntry = [[[OrderEntry alloc] initWithId:@"A2"] autorelease];
        NSLog(@"New order, ID = %@, item: %@", autoEntry->orderId, autoEntry->item->name);
    }
    return 0;
}
