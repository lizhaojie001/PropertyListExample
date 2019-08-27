//
//  XDFUploadTaskModel.swift
//  XDFNetworking
//
//  Created by xdf_yanqing on 2019/7/4.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

class XDFUploadTaskModel: NSObject {
    let url : URL
    let filePath : String
    convenience init(_ url : URL , filePath : String) {
        self.init()
        self.url = url
        self.filePath = filePath
    }
    
}
