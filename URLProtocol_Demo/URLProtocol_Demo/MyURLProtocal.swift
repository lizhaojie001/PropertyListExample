//
//  MyURLProtocal.swift
//  URLProtocol_Demo
//
//  Created by xdf_yanqing on 2019/7/9.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

class MyURLProtocal: URLProtocol {
    static let  requestCount = 0
    
    override class func canInit(with request: URLRequest) -> Bool {
        let sion = request.url?.pathExtension
        let isImage = ["png","jgp","gif","jpeg"].contains(sion)
        return isImage
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest
    {
        debugPrint(request.url?.absoluteString)

        return request
    }
    
    override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool
    {
       return super.requestIsCacheEquivalent(a, to: b)
    }

    override func startLoading() {
     }
    
    override func stopLoading() {
      
    }
}
