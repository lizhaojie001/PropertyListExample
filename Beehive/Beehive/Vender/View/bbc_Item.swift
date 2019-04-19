//
//  bbc_Item.swift
//  Beehive
//
//  Created by macbook pro on 2019/4/5.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import UIKit

class bbc_Item: NSObject {
    public var text : String?
    public var image : UIImage?
    convenience init(text : String , image : UIImage) {
        self.init()
        self.text = text
        self.image = image
    }
}
