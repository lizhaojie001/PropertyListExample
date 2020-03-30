//
//  ViewController.swift
//  NetServiceDemo
//
//  Created by xdf_yanqing on 2020/1/3.
//  Copyright © 2020 xdf_yanqing. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let service = NetService(domain: "local.yanqing", type: "_http._tcp.", name: "严青")
        service.delegate = self
        service.publish(options: [.listenForConnections])
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

extension ViewController : NetServiceDelegate {
    func netServiceWillPublish(_ sender: NetService) {
        debugPrint(#function)
    }
    
    
    func netServiceDidPublish(_ sender: NetService) {
        debugPrint(#function)
    }
    
    
    func netService(_ sender: NetService, didNotPublish errorDict: [String : NSNumber]) {
        debugPrint(#function,errorDict)
    }
    
    
    func netServiceWillResolve(_ sender: NetService) {
        
    }
    
    
    func netServiceDidResolveAddress(_ sender: NetService) {
        
    }
    
    
    func netService(_ sender: NetService, didNotResolve errorDict: [String : NSNumber]) {
        
    }
    
    
    func netServiceDidStop(_ sender: NetService) {
        
    }
    
    
    func netService(_ sender: NetService, didUpdateTXTRecord data: Data) {
        
    }
    
    
    @available(OSX 10.9, *)
    func netService(_ sender: NetService, didAcceptConnectionWith inputStream: InputStream, outputStream: OutputStream) {
        
    }
}
