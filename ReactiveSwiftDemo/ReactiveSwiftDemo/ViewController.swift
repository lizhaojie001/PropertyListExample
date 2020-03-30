//
//  ViewController.swift
//  ReactiveSwiftDemo
//
//  Created by xdf_yanqing on 2019/12/17.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa
import AVFoundation

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        signalProducerTag()
//        signalTag()
        recorder()
    }

    func recorder() {
        let temp = NSTemporaryDirectory()
        let filePath = temp.appending("memo.caf")
        let fileURL = URL(fileURLWithPath: filePath)
        let settings : [String : Any] = [AVFormatIDKey : kAudioFormatLinearPCM,
                                         AVSampleRateKey : 44100.0,
                                         AVNumberOfChannelsKey : 2,
                                         AVEncoderBitDepthHintKey : 32,
                                         AVLinearPCMIsFloatKey : true,
                                         AVLinearPCMIsBigEndianKey : false,
                                         AVLinearPCMIsNonInterleaved : false,
        ]
        let recorder = try? AVAudioRecorder(url: fileURL, settings: settings)
        recorder?.prepareToRecord()
        recorder?.record()
    }
    
    
    


  
}

