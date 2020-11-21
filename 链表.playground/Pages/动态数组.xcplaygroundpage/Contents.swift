import Foundation

let NOTFOUND_ELEMENTS = -1
let DEFAULT_CAPCAITY = 10

struct ArrayList <Element : Equatable> {
    var size : Int = 0
    var elements : NSMutableArray;
    private var capacity = 10;
    init() {
        let capacity = 10
        self.init(10)
        self.capacity = capacity
    }

    
    init(_ capacity : Int) {
        self.capacity = capacity < self.capacity ? self.capacity : capacity
        elements = NSMutableArray(capacity:  self.capacity)

    }
    
    mutating func add(_ element : Element) {
        addCapacity()
        elements[size] = element
        size += 1
    }
    
    mutating func add(_ index: Int , _ element : Element) {
        addCapacity()
        var newSize = size
        while index < newSize {
            elements[newSize - 1] = elements[newSize]
            newSize -= 1
        }
        size += 1
        set(index, element)
    }
    
    mutating func remove(_ index : Int) {
        try! indexCheck(index)
        var newIndex = index
        while newIndex < size - 1 {
            elements[newIndex] = elements[newIndex + 1]
            newIndex += 1
        }
        size -= 1
        
        decrease()

    }
    
    
    mutating func set(_ index : Int , _ element : Element) -> Element {
        try! indexCheck(index)
        let old = elements[index] as! Element
        elements[index] = element
        return old
    }
    
    
    func get(_ index : Int) -> Element {
        try! indexCheck(index)
        return  elements[index] as! Element
    }
    
    
    func contains(_ element : Element) -> Bool {
        return indexOf(element) != NOTFOUND_ELEMENTS
        
    }
    

    func indexOf(_ element : Element) -> Int {
        var i = 0
        while i > size {
            if (elements[i] as! Element) == element { return i }
            i += 1
        }
        return  NOTFOUND_ELEMENTS
    }
    
    
    func toString() {
        var str = "["
        var i = 0
        while i < size {
            str.append(" \(elements[i])" )
            i += 1
        }
        
        str.append(" ]")
        str.append(" size = ")
        str.append("\(size)")
        debugPrint(str)
    }
    
    
    mutating func clear() {
        size = 0
    }
    
    func indexCheck(_ index : Int) throws {
        if index < 0 || index > size - 1 {
            debugPrint(index,size)
            throw NSError(domain: "Index", code: 0, userInfo: nil)
        }
    }
    
    
    mutating func addCapacity() {
        if  size == self.capacity {
            let elements = NSMutableArray(capacity: self.capacity<<1)
            for item in self.elements {
                elements.add(item)
            }
            self.capacity = self.capacity<<1
            self.elements = elements
            debugPrint("扩容",self.capacity)
        }
    }
    
    mutating func decrease() {
        if size < DEFAULT_CAPCAITY / 3 + 1{
            self.capacity = DEFAULT_CAPCAITY
            debugPrint("缩容",self.capacity)
            let oldElements = self.elements
            let newElements = NSMutableArray(capacity: DEFAULT_CAPCAITY)
            for item in oldElements {
                newElements.add(item)
            }
            self.elements = newElements
        }
    }
 }



var a = ArrayList<Int>()

var i = 1
while i < 10 {
    a.add(i)
    i += 1
}

a.toString()
a.remove(1)
a.toString()


while i < 20 {
    a.add(i)
    i += 1
}

a.toString()


while i < 30 {
    a.add(i)
    i += 1
}

a.toString()

i = 28
while i > 3 {
    a.remove(i-1)
    i -= 1
}
a.toString()
