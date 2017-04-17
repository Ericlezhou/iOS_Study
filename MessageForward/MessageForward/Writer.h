//
//  Writer.h
//  MessageForward
//
//  Created by Eric on 2017/4/17.
//  Copyright © 2017年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Writer <NSObject>
- (void)write:(NSFileHandle *)file;
@end
