//
//  AppDelegate.swift
//  RC_4
//
//  Created by xdf_yanqing on 2019/4/4.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let key = "l102A1D18EE79"

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        let path = Bundle.main.path(forResource: "3and1", ofType: "png")
        let Key = key.data(using: String.Encoding.utf16)
        let data = NSData.init(contentsOfFile: path!)
        main(key: [UInt8](Key!), data: data! as Data )

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    
    
    

}



extension AppDelegate{
    //制作ksa
    @discardableResult
    func rc4_init(_ key : [UInt8], S : [uint8] , len : Int) -> [UInt8] {
        var S = S
//        var i  = 0
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

}
