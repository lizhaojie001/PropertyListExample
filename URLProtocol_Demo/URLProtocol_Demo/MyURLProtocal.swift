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
        debugPrint(request.url?.absoluteString)
        if request.url?.host == "myhost" {
            debugPrint(request.url?.absoluteString)
            return true
        }
        return false
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest
    {

        return request
    }
    
    override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool
    {
       return super.requestIsCacheEquivalent(a, to: b)
    }

    override func startLoading() {
        guard let url = self.request.url else { return }
        //        ZJLog(messages: url.absoluteString)
        if request.url?.absoluteString == "http://myhost/index.html" {
            var data : Data?
            var headerFields = [String : String]()
            
            let path = Bundle.main.path(forResource: "index", ofType: "html")
            let pathURL = URL(fileURLWithPath: path ?? "")
            do {
                data = try  Data(contentsOf: pathURL)
                headerFields = ["Access-Control-Allow-Origin" : "*" , "Content-Length" : "\(String(describing: data?.count))"]
            } catch {
                headerFields = [ "Access-Control-Allow-Origin" : "*" , "Content-Length" : "0"]
            }
            
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: headerFields)!
            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: URLCache.StoragePolicy.allowed)
            self.client?.urlProtocol(self, didLoad: data ?? Data())
            self.client?.urlProtocolDidFinishLoading(self)
        }
      
     }
    
    override func stopLoading() {
      
    }
}
