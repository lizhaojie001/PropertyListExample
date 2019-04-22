//
//  main.swift
//  return [URLSessionDownloadTask]() TaskSame
//
//  Created by xdf_yanqing on 2019/4/16.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Foundation

print("Hello, World!")


let 

let request = URLRequest(url: urlzip!)

let config = URLSessionConfiguration.background(withIdentifier: Url);
let currentSession = URLSession(configuration: config, delegate: self,
                                delegateQueue: OperationQueue() )
//下载任务
let downloadTask = currentSession.downloadTask(with: request)
