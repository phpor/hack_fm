//
//  CHTRemoteCalls.m
//  Chat
//
//  Created by Adam Burkepile on 9/9/13.
//  Copyright (c) 2013 Adam Burkepile. All rights reserved.
//

#import "CHTRemoteCalls.h"

@implementation CHTRemoteCalls

+ (void)sendMessage:(NSString*)message withBlock:(void(^)(NSString* returnJson))afterBlock;
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *destinationUrl = @"";
        if ([FMPlayCodeList rangeOfString:message].location !=NSNotFound) {
            destinationUrl = [NSString stringWithFormat:@"%@?action=%@",FMPlayAddress,message];
        }
        if ([FMOrderCodeList rangeOfString:message].location != NSNotFound) {
            destinationUrl = [NSString stringWithFormat:@"%@?action=%@",FMOrderAddress,message];
        }
        NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:destinationUrl]];
        NSURLResponse* response;
        NSError* err;
        NSData* data = [NSURLConnection sendSynchronousRequest:urlRequest
                                             returningResponse:&response
                                                         error:&err];
        
        if (data) {
            NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if (afterBlock) {
                afterBlock(returnString);
            }
        }
    });
}


@end
