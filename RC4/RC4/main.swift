//
//  main.swift
//  RC4
//
//  Cre/Users/macbookpro/Desktop/例子Demo/RC4/RC4.xcodeprojated by macbook pro on 2019/4/3.
//  Copyright © 2019 macbook pro. All rights reserved.
//  不做数据容错处理

import Foundation

print("Hello, World!")
let key = "l102A1D18EE79"

//制作ksa
@discardableResult
func rc4_init(_ key : [UInt8], S : [uint8] , len : Int) -> [UInt8] {
    var S = S
    var i  = 0
    var j  = 0
    var K : [Int] = Array.init(repeating: 0, count: 256)
    for i in 0...255{
        S[i] = uint8(i)
        K[i] = Int(key[i%len])
    }

    for i in 0...255{
        j = (j + Int(S[i]) + K[i])%256
        S.swapAt(i, j)
    }

    return S
}


func rc4_crypt(S : [uint8], data : Data , len : CLong) -> Data {
    var i = 0
    var j = 0
    var t = 0
    var S = S
    var data = data


    for k in 0...len {
        i = (i + 1)%256
        j = (j + Int(S[i]))%256
        S.swapAt(i, j)
        t = Int(S[i] + S[j])%256
        data[k] = data[k]^S[t]
    }
    return data
}
@discardableResult
func filter(_ bytes : [UInt8]) -> [UInt8] {
    debugPrint(bytes.count)
    let newBytes = bytes.suffix(from: 81)
    debugPrint(newBytes.count)
    return Array.init(newBytes)
}


func main(key:[uint8],data:Data) {
    var S : [UInt8] = Array(repeating: 0, count: 256)
    var S2 = Array(repeating: 0, count: 256)
    var key = key
    let len = data.count
    var i  = 0
    S = rc4_init(key, S: S, len: len)
    debugPrint(S)
}



/*
//制作 PRGA
func getPRGA(_ bytes: [UInt8] ) -> [UInt8] {
    var i = 0
    var j = 0
    var t = 0
    var k : Int?
    var S : [Int]?// = getKSA(key)
    var Bytes = bytes

    for _ in Bytes {
        i = (i+1)%256
        j = (j + S?[i])%256
        S.swapAt(i, j)
        t = (S?[i] + S[j])%256
        k = S?[t]
    }
    i = 0
    while i < Bytes.count {
        var byte = Bytes[i]
        byte = byte ^ UInt8(k!)
        Bytes[i] = byte
        i = i + 1
    }
    return Bytes
}



@discardableResult
func getBytesFormFilePath(_ path : String) -> [UInt8] {
    do {
        let data = try NSData.init(contentsOfFile: path) as Data
        let bytes = [UInt8](data)
        debugPrint(bytes)

        return bytes
    } catch  {
        debugPrint(error)
    }
    return []
}


//getKSA("l102A1D18EE79")
let path = "/Users/macbookpro/Downloads/images/ddz_game/waiting/1.png"
let bytes = getBytesFormFilePath(path)

//filter(bytes)
//getBytesFormFilePath("/Users/macbookpro/Downloads/images/ddz_game/waiting/2.png")

let pngBytes = getPRGA(filter(bytes))
let data = Data.init(bytes: pngBytes)
let string =  NSString.init(data: data, encoding: String.Encoding.utf16.rawValue)

try string?.write(to: URL.init(fileURLWithPath: "/Users/macbookpro/Downloads/images/ddz_game/waiting/0.png"), atomically: true, encoding: String.Encoding.utf16.rawValue)
//try string.write(to: URL.init(fileURLWithPath: "/Users/macbookpro/Downloads/images/ddz_game/waiting/0.png"))

*/
//混淆字符  fackyou!
let a = [102, 117, 99, 107, 121, 111, 117, 33, 45, 65, 214, 148, 191, 75, 61, 133, 86, 20, 241, 121, 191, 130, 164, 47, 50, 255, 146, 223, 54, 168, 148, 44, 248, 19, 220, 247, 198, 181, 73, 191, 43, 161, 18, 40, 241, 92, 239, 86, 152, 110, 100, 168, 75, 217, 229, 56, 150, 35, 45, 161, 147, 39, 143, 181, 173, 36, 126, 85, 38, 201, 190, 124, 241, 109, 106, 42, 209, 50, 220, 91, 86]
let ddd = Data.init(bytes: a, count: a.count)
//let kkk = String.init(data: data, encoding: String.Encoding.utf8)
//debugPrint(kkk)
debugPrint(a.count)


let path = "/Users/macbookpro/Downloads/images/ddz_game/waiting/1.png"
let Key = key.data(using: String.Encoding.utf16)
main(key: [UInt8](Key!), data: try Data.init(contentsOf: URL.init(fileURLWithPath: path)))

