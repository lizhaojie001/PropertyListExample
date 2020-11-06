//: [Previous](@previous)

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next;
    }
}


func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    //快慢指针
    if head == nil {
        return head
    }
    
    if n == 0 { return head }
    var prePrev = ListNode(-1)
    prePrev.next = head
    var fast : ListNode?  = prePrev
    var slow : ListNode?  = prePrev
    var leng = head
    var l = 0
    while leng != nil {
        leng = leng?.next
        l += 1
    }
    if n > l { return  head }
    var k = n
    while k >= 0 {
        k -= 1
        fast = fast?.next
    }
    while fast != nil {
        slow = slow?.next
        fast = fast?.next
    }
    slow?.next = slow?.next?.next
    return prePrev.next
}
