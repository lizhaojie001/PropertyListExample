\//
//  XDFUploadManager.swift
//  XDFNetworking
//
//  Created by xdf_yanqing on 2019/7/4.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

class XDFUploadManager: NSObject {
    static let  shared = XDFUploadManager()
    lazy var manager: URLSession = {
        let cfg = URLSessionConfiguration.default
        let session = URLSession(configuration: cfg,delegate: self,delegateQueue: OperationQueue())
        return session
    }()
    
    /// 最大为3
    var maxUploadCount : UInt = 1 {
        didSet {
            if maxUploadCount > 3 {
                maxUploadCount = 3
                assert(maxUploadCount <= 3 , "最大并发数为3")
            }
        }
    }
    
    /// 正在下载
    private lazy var downloadingTasks : [XDFUploadTaskModel] = {
        let tasks = [XDFUploadTaskModel]()
        return tasks
    }()
    
    /// 等待下载任务
    private lazy var waittingTasks : [XDFUploadTaskModel] = {
        let tasks = [XDFUploadTaskModel]()
        return tasks
    }()
    
    
    
    func uploadFile(_ uploadUrl : URL , filePath : String) {
        let uploadTask = XDFUploadTaskModel(uploadUrl,filePath: filePath)
        waittingTasks.append(uploadTask)
        let count = waittingTasks.count
        if  count <= maxUploadCount && downloadingTasks.count == 0{
              downloadingTasks = waittingTasks
        } else {
            let count = downloadingTasks.count
            let needCount = maxUploadCount - count
            let tasks = waittingTasks.dropFirst(count - maxUploadCount)
            waittingTasks.removeFirst(maxUploadCount - count)
           //不考虑重复下载
        }  
    }
    
    func resume(){
        
        
        
        let uploadTask = manager.uploadTask(with: URLRequest(url: uploadUrl), fromFile: URL(fileURLWithPath: filePath)) { (data, response, error) in
            
        }
        
          uploadTask.resume()
    }
}

extension XDFUploadManager : URLSessionTaskDelegate , URLSessionDelegate {
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        
    }
   
    
    
    
}
