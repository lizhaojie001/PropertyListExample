//
//  main.swift
//  TestT
//
//  Created by xdf_yanqing on 1/21/21.
//

import Foundation

print("Hello, World!")

//按位异或

var flag : UInt32 = 1<<15
let tag : UInt32 = ~(1<<15)
debugPrint(String( 1<<14,radix: 2))
debugPrint(String(flag | 1<<14,radix: 2),String( flag & ~(1<<15) ,radix: 2))
//将某一位置1
 let n = 13
let new = flag | (1<<n)
debugPrint(String(new,radix: 2))

//将某一位置0
flag = 1<<2
debugPrint(String(flag,radix: 2))
let set0 = flag & (~(1<<2))
debugPrint(String(set0,radix: 2))


//冒泡排序

var array = [12,54,3,89,32,44,22,234,4]
var begin = 1
var end = array.count - 1
while end > 0 {
    begin = 1
    while begin <= end {
        if array[begin] < array[begin-1] {
            let temp = array[begin]
            array[begin] = array[begin-1]
            array[begin-1] = temp
        }
        begin += 1
    }
    end -= 1
}

for item in array {
    debugPrint(item)
}
