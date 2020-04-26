//
//  main.m
//  nshift
//
//  Created by xdf_yanqing on 2020/4/23.
//  Copyright © 2020 xdf_yanqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBBlueLightClient.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSBundle *a = [NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/CoreBrightness.framework"];
        if (![a load]) {
            return 0;
        }
        if (argc == 1) { return 0; }
        float strength = [[NSString stringWithUTF8String:argv[1]] floatValue] / 100;
        CBBlueLightClient *client = [[CBBlueLightClient alloc] init];
        if (strength != 0.0) { [client setStrength:strength commit:true]; }
        [client setEnabled:(strength != 0.0)];
    }
    return 0;
}
