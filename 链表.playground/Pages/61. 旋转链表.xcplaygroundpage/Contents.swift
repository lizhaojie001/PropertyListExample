//: [Previous](@previous)

 
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}


/// 解题思路
///1.获取列表长度,求给定移动长度和列表长度的余数 mod   余数为0时不做移动
///2. 反转实际是将倒数第k个节点作为head,然后将原结尾拼接到原head ,倒数第k+1指向nil
/// - Parameter head: <#head description#>
/// - Parameter k: <#k description#>
func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
    if head == nil { return head }
    var l = 0
    var tail = head
    while tail != nil {
        tail = tail?.next
        l += 1
    }
    let rotate = k%l
    if rotate == 0 { return head }
    var pre = head
    var i = 1
    while l - i > rotate {
        i += 1
        pre = pre?.next
    }
    let newHead = pre?.next
    pre?.next = nil
    tail?.next = head
    
    return newHead
}

let a = 2%25
debugPrint(a)

