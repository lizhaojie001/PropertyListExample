//
//  HYTool.swift
//  VideoBox
//
//  Created by xdf_yanqing on 2019/10/17.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import UIKit
import AudioToolbox
let HYToolinstance = HYTool.shared
class HYTool: NSObject {
    static var shared = HYTool()
    var isShake = true

    func shake( isShake : Bool = true)  {
        if isShake && self.isShake{
            AudioServicesPlaySystemSound(1519)
        }
    }
}
