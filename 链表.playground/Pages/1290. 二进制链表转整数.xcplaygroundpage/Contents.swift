//: [Previous](@previous)

//给你一个单链表的引用结点 head。链表中每个结点的值不是 0 就是 1。已知此链表是一个整数数字的二进制表示形式。
//请你返回该链表所表示数字的 十进制值 。
 
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}



/// 解题思路:
/// 右移 使原来的值扩大两倍 根据 结合律 高位 右移 n-1 次高位 右移 n-2 ...
///
/// - Parameter head: <#head description#>
func getDecimaValue(_ head : ListNode?) -> Int {
    if head == nil { return 0 }
    var current = head
    var value = 0
    while current != nil {
        value = value * 2 + current!.val
        current = current?.next
    }
    return value
}
