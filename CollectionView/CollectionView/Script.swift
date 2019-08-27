//
//  Script.swift
//  CollectionView
//
//  Created by xdf_yanqing on 2019/8/27.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

class Script: NSObject {
    @discardableResult
    public class func runScript(path:String, arguments:[String]) -> String? {
        if #available(OSX 10.13, *) {
            let process = Process()
            process.executableURL = URL(fileURLWithPath: path)
            process.arguments = arguments
            let pip = Pipe()
            process.standardOutput = pip
            let fileHandle = pip.fileHandleForReading
            do {
                try process.run()
            } catch let error {
                debugPrint("fectch cpuInfo Error:\(error)")
                return nil
            }
            let data = fileHandle.readDataToEndOfFile()
            return String(data: data, encoding: String.Encoding.utf8) ?? ""
        }
        let task = Process()
        task.launchPath = path
        task.arguments = arguments
        let pip = Pipe()
        task.standardOutput = pip
        let fileHandle = pip.fileHandleForReading
        task.launch()
        let data = fileHandle.readDataToEndOfFile()
        return String(data: data, encoding: String.Encoding.utf8)
    }
}
