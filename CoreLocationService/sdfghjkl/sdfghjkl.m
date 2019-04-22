//
//  sdfghjkl.m
//  sdfghjkl
//
//  Created by xdf_yanqing on 2019/4/18.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

#import "sdfghjkl.h"

@implementation sdfghjkl

// This implements the example protocol. Replace the body of this class with the implementation of this service's protocol.
- (void)upperCaseString:(NSString *)aString withReply:(void (^)(NSString *))reply {
    NSString *response = [aString uppercaseString];
    reply(response);
}

@end
