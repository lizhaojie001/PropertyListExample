//
//  HYTypeButton.swift
//  VideoBox
//
//  Created by macbook pro on 2019/12/12.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import UIKit

class HYTypeButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    enum Etype : Int {
        case low = 0
        case nomal
        case hight
    }
    
    var type = Etype.low
    
}
