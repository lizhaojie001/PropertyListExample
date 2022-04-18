import CoreMedia
//:冒泡 针对于整形
func bubbleSort1( array : [Int]) {
    let time = CFAbsoluteTimeGetCurrent()
    var array = array
    var i = array.count - 1;
    while i > 0 {
        var j = 0;
        while j < i  {
            if array[j] > array[j+1] {
                let tmp = array[j]
                array[j] = array[j+1]
                array[j+1] = tmp
            }
            
            j+=1;
        }
        i-=1;
    }
    debugPrint("耗时:" + #function + ":" + "\(CFAbsoluteTimeGetCurrent() - time)")
    debugPrint(array)
}


var arrays = [2,3,5,6,34,5,3,4,3,43,32,4,55,100]
bubbleSort1(array: arrays)


//冒泡优化1 ,针对于尾部有序数组 找到最后比较元素的位置

arrays = [49,39,2,31,2,34,42,3, 34, 43, 55, 100]
 
func bubbleSort2( array : [Int]) {
    let time = CFAbsoluteTimeGetCurrent()

    var array = array
    var end = array.count - 1
    while end > 0 {
        var j = 0;
        var maxIndex = 0;
        while j < end {
            if array[j] > array[j+1] {
                let tmp = array[j]
                array[j] = array[j+1]
                array[j+1] = tmp
                maxIndex = j;
            }
            j+=1;
        }
        
        end = maxIndex;
    }
    debugPrint("耗时:" + #function + ":" + "\(CFAbsoluteTimeGetCurrent() - time)")

    debugPrint(array)
}

bubbleSort2(array: arrays)
