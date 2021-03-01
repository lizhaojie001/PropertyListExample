//
//  main.swift
//  CompareAble
//
//  Created by xdf_yanqing on 1/20/21.
//

import Foundation

print("Hello, World!")
class A : NSObject {
    override func isEqual(to object: Any?) -> Bool {
        guard let data = object as? A else {
            return false
        }
        return data.uid == self.uid
    }
    
    var uid : Int = 0
    
    override var description: String {
        return "\(self.uid)"
    }
}

let m = A()
m.uid = 1

let n = A()
n.uid = 2
var array = [m,n]

let M = A()
M.uid = 3
 array.removeAll { (a) -> Bool in
    return a == M
}
array.insert(n, at: 0)

let inxde = array.index(after: 3)
debugPrint(inxde == array.endIndex)
debugPrint(array,inxde)

 
