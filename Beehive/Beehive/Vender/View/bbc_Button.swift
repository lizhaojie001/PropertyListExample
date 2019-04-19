//
//  bbc_Button.swift
//  Beehive
//
//  Created by macbook pro on 2019/3/31.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift
let color1 = "#EA6963"
let color2 = "#CCEAF3"
let color3 = "#FBD361"
let color4 = "#C9BBCB"

class bbc_Button: UIButton {

    convenience init(text:String) {
        self.init()
        setTitle(text, for: .normal)
        backgroundColor = UIColor(color3)
        setTitleColor(UIColor.black, for: state)

    }
    override func backgroundImage(for state: UIControl.State) -> UIImage? {
        return UIImage()
    }
    override func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(UIImage(), for: state)
    }

    override func titleColor(for state: UIControl.State) -> UIColor? {
        return UIColor(color1)
    }

    override func draw(_ rect: CGRect) {
//        super.draw(rect)
        let be = UIBezierPath(roundedRect: rect, cornerRadius: 7)
        let path = be.cgPath
        let mask = CAShapeLayer()
        mask.frame = layer.bounds
        mask.path = path
        layer.mask = mask
    }
}
