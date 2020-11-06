//: [Previous](@previous)

 
  public class ListNode {
      public var val: Int
      public var next: ListNode?
    public init(_ val: Int , next : ListNode?) {
          self.val = val
         self.next = nil
      }
  }
 
class Solution {
    func reverseList(_ head: ListNode?) -> ListNode? {
       var prev : ListNode?
       var current = head
       while(current != nil){
           let temp = current?.next
           current?.next = prev
           prev = current
           current = temp
       }
       return prev
    }
}

let so = Solution()


