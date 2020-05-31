//
//  ViewController.swift
//  Voice_demo
//
//  Created by macbook pro on 2020/5/31.
//  Copyright © 2020 macbook pro. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController , AVSpeechSynthesizerDelegate {

    @IBOutlet weak var textField: UITextField!
    var voice : AVSpeechSynthesizer = {
        let  vocie = AVSpeechSynthesizer()
        return vocie
    }()
    
    var speech : AVSpeechUtterance = {
        let s = AVSpeechUtterance(string: "刘萌萌是个嘿嘿的女孩,爱吃爱睡,爱看综艺,胖")
        s.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        s.pitchMultiplier = 1
        s.volume = 1
        s.rate = 0.5
        return s
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        voice.delegate = self
    }

    @IBAction func speech(_ sender: UIButton) {
        let path = "/Users/macbookpro/Desktop/123/waf.caf"
        self.voice.write(self.speech) { (buffer) in
            if let pcmBuffer = buffer as? AVAudioPCMBuffer {
                let data = self.toNSData(PCMBuffer: pcmBuffer)
                try? data.write(toFile: path, options: [.atomic])
            }
        }
//        self.voice.speak(self.speech)
    }
    
    func toNSData(PCMBuffer: AVAudioPCMBuffer) -> NSData {
        let format = PCMBuffer.format
        let channelCount = format.channelCount  // given PCMBuffer channel count is 1
        let channels = UnsafeBufferPointer(start: PCMBuffer.int16ChannelData, count: Int(channelCount))
        let mBytesPerFrame = format.streamDescription.pointee.mBytesPerFrame
        let ch0Data = NSData(bytes: channels[0], length:Int(PCMBuffer.frameCapacity * mBytesPerFrame))
        return ch0Data
    }
}



