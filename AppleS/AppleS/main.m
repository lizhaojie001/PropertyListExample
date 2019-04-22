//
//  main.m
//  AppleS
//
//  Created by xdf_yanqing on 2019/4/17.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppleScriptObjC/AppleScriptObjC.h>

int main(int argc, const char * argv[]) {
    [[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];
    return NSApplicationMain(argc, argv);
}
