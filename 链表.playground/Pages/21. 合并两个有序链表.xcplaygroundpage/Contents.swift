//: [Previous](@previous)

///https://leetcode-cn.com/problems/merge-two-sorted-lists/

//[!图片](/Resources/1.png)
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next;
    }
    
    
    /// 将两个升序链表合并为一个新的 升序 链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。
    /// - Parameter l1: <#l1 description#>
    /// - Parameter l2: <#l2 description#>
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil {
            return l2
        }
        if l2 == nil {
            return l1
        }
        var first = l1
        var scound = l2
        let prePrev = ListNode(-1)
        let isFirst = l1!.val >= l2!.val
        prePrev.next = isFirst ? scound : first
        var newHead : ListNode? = prePrev
        while first != nil && scound != nil {
            if first!.val >= scound!.val {
                newHead?.next = scound
                scound = scound?.next
            } else {
                newHead?.next = first
                first = first?.next
            }
            newHead = newHead?.next
        }
        newHead?.next = first == nil ? scound : first
        return prePrev.next
    }
}
