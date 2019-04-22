//
//  sdfghjkl.h
//  sdfghjkl
//
//  Created by xdf_yanqing on 2019/4/18.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sdfghjklProtocol.h"

// This object implements the protocol which we have defined. It provides the actual behavior for the service. It is 'exported' by the service to make it available to the process hosting the service over an NSXPCConnection.
@interface sdfghjkl : NSObject <sdfghjklProtocol>
@end
