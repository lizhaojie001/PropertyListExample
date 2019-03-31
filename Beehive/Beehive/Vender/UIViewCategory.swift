//
//  UIViewCategory.swift
//  Beehive
//
//  Created by macbook pro on 2019/3/31.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import Foundation

extension UIView {

    func X() -> CGFloat {
        return self.frame.origin.x
    }
    func Y() -> CGFloat {
        return self.frame.origin.y
    }
    func centerX() -> CGFloat {
        let width = self.frame.width
        let x = self.X()
        let centerX = x + 0.5 * width
        return centerX
    }

    func centerY() -> CGFloat {
        let height = self.frame.height
        let y = self.Y()
        let centerY = y + 0.5 * height
        return centerY
    }
    


}
