//: [Previous](@previous)

import Foundation
import Cocoa
//任意节点的值大于左子树节点的值
//任意节点的值小于右子树节点的值
//左右子树都是二叉搜索树
//二叉搜索树的节点具有可比性

public class ListNode<E >  {
    public var element: E
    public var right: ListNode?
    public var left : ListNode?
    public var parent : ListNode?
    init(_ element: E, _ parent: ListNode<E>?) {
        self.element = element
        self.parent = parent
    }
}

class Person{
    static func == (r : Person, l : Person?) ->Bool {
        guard let l = l else { return false }
        return r.age == l.age
    }
    
    private(set) var age : Int = 0;
    private(set) var name : String?
    convenience init(_ age : Int , _ name : String? = nil) {
        self.init()
        self.age = age
        self.name = name
    }
    
   
}



struct BinarySearchTree<E> {
    
    
    init(_ compareBlock :  ((E,E)->Int)?) {
        self.compareBlock = compareBlock
    }
    
    var compareBlock : ((E,E)->Int)?
    var root : ListNode<E>?
    var size : Int = 0;
    mutating func add(_ element : E) {
       try! elementNotNilCheck(element)
        if root == nil {
            root = ListNode(element,nil)
            size += 1
            return
        }
        
        //寻找父节点
        var node : ListNode<E>? = root
        var parent : ListNode<E>?
        var compareValue = 0
        while node != nil {
            let value = compare(element ,node!)
            compareValue = value
            parent = node
            if value < 0 { //left
                node = node?.left
            } else if value > 0 { //right
                node = node?.right
            } else { // equal
                node?.element = element
                return
            }
        }
        let newNode = ListNode(element,parent)
        if compareValue > 0 {
            parent?.right = newNode
        } else {
            parent?.left = newNode
        }
        size += 1
    }
    
    
    func isEmpty() -> Bool {
        return root == nil
    }
    
    mutating func clear() {
        root = nil
    }
    
    func remove( _ element : E) {
        
    }
    
    func contains(_ element : E) -> Bool {
        return false
    }
    
    func elementNotNilCheck(_ element : E?) throws {
        if element == nil {
            throw NSError(domain : "123" , code : 123 , userInfo : nil)
        }
    }
    func compare(_ element1 : E ,_ node : ListNode<E> ) -> Int {
        if let block = self.compareBlock {
            return block(element1,node.element)
        }
        return -1
    }
}

