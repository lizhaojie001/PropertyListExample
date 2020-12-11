//
//  main.swift
//  Tree
//
//  Created by xdf_yanqing on 12/11/20.
//

import Foundation



func  test2() {
    let solu = Solution()
    let nums = [-10,-3,0,1,5,9,10]
//    let tre = tree.sortedArrayToBST(nums)
    solu.midPrint(nums)
    
    
}

/// 二叉搜索树遍历
func test1()  {
    let ages = [1,29,3,40,5,4,53,23,43,12,434,423,212,33]
    var tree = BinarySearchTree<Person> { (p1, p2) -> Int in
        return p1.age - p2.age
    }
    debugPrint("开始")
    for age in ages {
        let person = Person(age)
        tree.add(person)
    }
    debugPrint("结束")

    //tree.levelTree()


    //tree.frontTree()
    //tree.LRDTree()
    //tree.midTree()
}


test2()

