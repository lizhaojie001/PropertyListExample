
let array = [[1,3,4,5] , [4,5,5] , [12,3]]
let a1 = array.flatMap { (cla) -> [Int] in
    return cla
}.reduce(0) { (x, a) -> Int in
    return x + a
}

 
  public class ListNode {
      public var val: Int
      public var next: ListNode?
      public init(_ val: Int) {
          self.val = val
         self.next = nil
      }
  }
 
class Solution {
    func deleteNode(_ node: ListNode?) {
        node?.val = node?.next?.val ?? 0
        node?.next = node?.next?.next
        
    }
}
