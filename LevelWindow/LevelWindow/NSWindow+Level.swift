//
//  NSWindow+Level.swift
//  LevelWindow
//
//  Created by xdf_yanqing on 2019/3/27.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import AppKit

protocol NSWindowExtensionProtocol {
    var subWindows : [NSWindow] {get set}
    
}


extension NSWindow : NSWindowExtensionProtocol{
    var subWindows: [NSWindow] {
        get {
           return self.childWindows ?? []
        }
        set {
        
        }
    }
    
    func bringSubwindowToFront(window:NSWindow) {
        removeChildWindow(window)
        addChildWindow(window, ordered: NSWindow.OrderingMode.above)
    }
    
    
  
    
    
    
}




