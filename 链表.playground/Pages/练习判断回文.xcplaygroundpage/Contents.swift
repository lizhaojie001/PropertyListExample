
let str = "abcdedcbaabcdedcba"

//1.从0开始到 str.length/2 入栈
let count = str.count
var i = count / 2
let strArr = Array(str)
var 回文 : Bool = true
while  i > 0 {
    let pre = strArr[i-1]
    let suff = strArr[count-i]
    debugPrint(pre,suff)
    if pre != suff {
         回文 = false
        break
    }
    i -= 1
}

if 回文 {
    debugPrint("是回文")
} else {
    debugPrint("不是回文")
}
