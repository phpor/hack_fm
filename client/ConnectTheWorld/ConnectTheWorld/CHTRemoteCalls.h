//
//  CHTRemoteCalls.h
//  Chat
//
//  Created by Adam Burkepile on 9/9/13.
//  Copyright (c) 2013 Adam Burkepile. All rights reserved.
//

#import <Foundation/Foundation.h>
#define CategoryButtonList @"listen,clear"
#define FMPlayCodeList @"info,stop,play,skip"
#define FMOrderCodeList @"fuqing,song2"

#define FMPlayAddress @"http://172.16.121.180/api/fmc.php"
#define FMOrderAddress @""
@interface CHTRemoteCalls : NSObject
+ (void)sendMessage:(NSString*)message withBlock:(void(^)(NSString* returnJson))afterBlock;

@end
