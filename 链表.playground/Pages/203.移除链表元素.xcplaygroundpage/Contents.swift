//: [Previous](@previous)
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        if head == nil { return head }
        var current = head
        var pre = head
        var first : ListNode?
        while current != nil {
            if current?.val != val {
                if first == nil {
                    first = current
                }
                pre = current
            } else {
                pre?.next = current?.next
            }
            current = current?.next
        }
        
        return first
    }
    
    /// 递归解法
    /// - Parameter head: <#head description#>
    /// - Parameter val: <#val description#>
    func removeElements2(_ head: ListNode?, _ val: Int) -> ListNode? {
        if head == nil { return head }
        
         
          return nil
      }
    
    /// 类似题目
    /// - Parameter nums: <#nums description#>
    /// - Parameter val: <#val description#>
    func removeElement3(_ nums: inout [Int], _ val: Int) -> Int {

        return 0
    }
}

let so = Solution()
var arr : [Int] = [4,5]
let a = so.removeElement3(&arr,5)
debugPrint(a,arr)
