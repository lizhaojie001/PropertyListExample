//
//  UIViewExtension.swift
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
        let centerX = x + width * 0.5
        return centerX
    }
    func centerY() -> CGFloat {
        let width = self.frame.height
        let x = self.Y()
        let centerX = x + width * 0.5
        return centerX
    }
    func setX(_ x:CGFloat) -> Void {
        var frame = self.frame
        frame.origin.x = x
        self.frame = frame
    }
    func setY(_ y :CGFloat) -> Void {
        var frame = self.frame
        frame.origin.y = y
        self.frame = frame
    }
    func setCenterX(_ centerX : CGFloat) -> Void {
        var frame = self.frame
        let width = self.frame.width
        frame.origin.x = centerX - width * 0.5
        self.frame = frame
    }
    func setCenterY(_ centerY : CGFloat) -> Void {
        var frame = self.frame
        let width = self.frame.height
        frame.origin.y = centerY - width * 0.5
        self.frame = frame
    }

}
