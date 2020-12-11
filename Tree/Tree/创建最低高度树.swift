//
//  创建最低高度树.swift
//  Tree
//
//  Created by xdf_yanqing on 12/11/20.
//https://leetcode-cn.com/problems/minimum-height-tree-lcci/

import Foundation
 
//  Definition for a binary tree node.
  public class TreeNode {
      public var val: Int
      public var left: TreeNode?
      public var right: TreeNode?
      public init(_ val: Int) {
          self.val = val
          self.left = nil
          self.right = nil
      }
  }
 

 //创建一个完全二叉树
class Solution {
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        if nums.count == 0 { return nil }
        let root = TreeNode(nums[0])
        for nu in nums {
            add(nu, root)
        }
        
        return root
    }
    
    func add(_ element : Int ,_ root : TreeNode) {
         //找父节点
        var parent : TreeNode?
        var node : TreeNode? = root
        var cmp = 0
        while node != nil {
            let val = node!.val
            parent = node
            cmp = element - val
            if cmp < 0 {
                node = node?.left
            } else if cmp > 0 {
                node = node?.right
            } else {
                return
            }
        }
        let newNode = TreeNode(element)
        if cmp < 0 {
            parent?.left = newNode
        } else {
            parent?.right = newNode
        }
     }
    
    func midPrint(_ nums : [Int]) {
        if nums.count == 0 { return  }
        let root = TreeNode(nums[0])
        for nu in nums {
            add(nu, root)
        }
        midTRee(root)
    }
    
    private func midTRee(_ root:TreeNode?) {
        if root == nil{
            return
        }
        midTRee(root?.left)
        debugPrint(root?.val)
        midTRee(root?.right)
    }
    
}
