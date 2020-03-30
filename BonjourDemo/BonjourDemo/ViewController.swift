//
//  ViewController.swift
//  BonjourDemo
//
//  Created by xdf_yanqing on 2020/1/3.
//  Copyright © 2020 xdf_yanqing. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    let domainBrowser = NetServiceBrowser()
    override func viewDidLoad() {
        super.viewDidLoad()
        domainBrowser.delegate = self
//        domainBrowser.searchForServices(ofType: "_services._dns-sd._udp.", inDomain: "local.")
        domainBrowser.searchForBrowsableDomains()
        domainBrowser.schedule(in: RunLoop.current, forMode: RunLoop.Mode.common)
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func end(_ sender: Any) {
        domainBrowser.stop()
    }
    
    @IBAction func start(_ sender: Any) {
        domainBrowser.searchForRegistrationDomains()
    }
}

extension ViewController : NetServiceBrowserDelegate {
    func netServiceBrowserWillSearch(_ browser: NetServiceBrowser) {
        debugPrint("将开始搜索")
    }
    
    
    func netServiceBrowserDidStopSearch(_ browser: NetServiceBrowser) {
        debugPrint("结束搜索")
    }
    
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didNotSearch errorDict: [String : NSNumber]) {
        debugPrint(#function , errorDict)
    }
    
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didFindDomain domainString: String, moreComing: Bool) {
        debugPrint(#function,domainString,moreComing)
    }
    
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        debugPrint(#function,service.name,moreComing)
    }
    
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didRemoveDomain domainString: String, moreComing: Bool) {
        debugPrint(#function , domainString , moreComing)
    }
    
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didRemove service: NetService, moreComing: Bool) {
        debugPrint(#function , service.name , moreComing)
    }
}
