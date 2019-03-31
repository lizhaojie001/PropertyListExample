//
//  SafariExtensionViewController.swift
//  Safari
//
//  Created by macbook pro on 2019/3/30.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import SafariServices

class SafariExtensionViewController: SFSafariExtensionViewController {
    
    static let shared: SafariExtensionViewController = {
        let shared = SafariExtensionViewController()
        shared.preferredContentSize = NSSize(width:320, height:240)
        return shared
    }()

}
