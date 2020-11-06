//: [Previous](@previous)


/// 快慢指针



public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}


/// 让快指针领先kc次
/// - Parameter node: <#node description#>
/// - Parameter k: <#k description#>
func findK(_ head : ListNode? ,_  k : Int ) -> Int {
    var fast = head
    var slow = head
    var k = k
    while k > 0 {
        fast = fast?.next
        k -= 1
    }
    while fast?.next != nil {
        fast = fast?.next
        slow = slow?.next
    }
    return slow?.val ?? k
}

class Solution {
    func kthToLast(_ head: ListNode?, _ k: Int) -> Int {
        var fast = head
        var slow = head
        var k = k
        while k > 1 {
        fast = fast?.next
        k -= 1
        }
        while fast?.next != nil {
        fast = fast?.next
        slow = slow?.next
        }
        return slow?.val ?? k
    }
}
