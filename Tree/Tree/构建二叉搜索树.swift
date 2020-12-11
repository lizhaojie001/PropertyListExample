//
//  构建二叉搜索树.swift
//  Tree
//
//  Created by xdf_yanqing on 12/11/20.
//

import Foundation
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

class Person : NSObject{
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
    
    override var description: String {
        return "\(age)"
    }
}



struct BinarySearchTree<E> {
    
    private func _LRDTree(_ node : ListNode<E>?){
        if node == nil
        {
            return
        }
        _LRDTree(node?.left)
        _LRDTree(node?.right)
        debugPrint(node?.element)

    }
    func LRDTree(){
        _LRDTree(root)
    }
    
    private func _midTree(_ node : ListNode<E>?){
        if node == nil
        {
            return
        }
        _midTree(node?.left)
        debugPrint(node!.element)
        _midTree(node?.right)
    }
    func midTree() {
        _midTree(root)
    }
    
   private func _frontTree(_ node : ListNode<E>?) {
        if node == nil
        {
            return
        }
        debugPrint(node?.element)
        _frontTree(node?.left)
        _frontTree(node?.right)
    }
    
    func frontTree() {
        _frontTree(root)
    }
    
    /// 层级遍历
    func levelTree() {
        let capacity = 100
        let queue = NSMutableArray(array: [0])
        var tail = 0
        var head = 0
        if let node = root  {
            tail = (tail + 1)%capacity
            queue[tail] = node
        } else {
            debugPrint("root = nil")
            return
        }
        while tail != head {
            head = (head+1)%capacity
            let node = queue[head] as! ListNode<E>
            debugPrint(node.element)
            if node.left != nil {
                tail = ( tail + 1 )%capacity
                queue.insert(node.left!, at: tail)
                
            }
            if node.right != nil {
                tail = ( tail + 1 )%capacity
                queue.insert(node.right!, at: tail)
            }
        }
    }
    
    
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
            debugPrint(element,"right",parent?.element)

        } else {
            parent?.left = newNode
            debugPrint(element,"left",parent?.element)
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
