//
//  main.m
//  Memory_alignment
//
//  Created by xdf_yanqing on 2020/9/8.
//  Copyright © 2020 xdf_yanqing. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
有效对齐值 : 是给定值#pragma pack(n)和结构体中最长数据类型长度中较小的那个。有效对齐值也叫对齐单位。
 
内存对齐的两条原则
  1. 结构体第一个成员的偏移量（offset）为0，以后每个成员相对于结构体首地址的 offset 都是该成员大小与有效对齐值中较小那个的整数倍，如有需要编译器会在成员之间加上填充字节。
  2. 结构体的总大小为 有效对齐值 的整数倍，如有需要编译器会在最末一个成员之后加上填充字节。

 
注意:
 pack 只能设置 1 2 4 8 16 不信你试试
*/

#pragma pack(2)

struct {
    int a;
    char b;
}T1;
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        printf("%lu\n",sizeof(T1));
    }
    return 0;
}
