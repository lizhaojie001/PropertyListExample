//
//  main.m
//  GetIvars
//
//  Created by xdf_yanqing on 2020/8/27.
//  Copyright © 2020 xdf_yanqing. All rights reserved.
//

#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
////遍历获取Person类所有的成员变量IvarList
void getAllIvarList(Class cls) {
    id objc = [[cls alloc] init];
    Class cls1 = NSClassFromString(@"_NSSliderCellPrivateData");
    Class cls2 = NSClassFromString(@"NSSliderAccessory");
    NSLog(@"%@",class_getSuperclass([cls class]));
    unsigned int methodCount = 0;
    Ivar * ivars = class_copyIvarList(cls2, &methodCount);
    for (unsigned int i = 0; i < methodCount; i ++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        const char * type = ivar_getTypeEncoding(ivar);
        NSLog(@"NSSliderCell拥有的成员变量的类型为%s，名字为 %s\n ",type, name);
        NSString * t =  [NSString stringWithCString: type encoding: NSUTF8StringEncoding];
        if ([t isEqualToString: @"@"]) {
//            NSLog(@"%@", object_getIvar(cls2, ivar));
        }
    }
    free(ivars);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        getAllIvarList([NSSliderCell class]);
        
    }
    return 0;
}


