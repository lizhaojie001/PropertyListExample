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
    
    lazy var playerNode : AVAudioPlayerNode = {
        let player = AVAudioPlayerNode()
        return player
    }()
    
    var isSetUp = false
    
    lazy var engine: AVAudioEngine = {
        let engine = AVAudioEngine()
        return engine
    }()
    
    var speech : AVSpeechUtterance = {
        let s = AVSpeechUtterance(string: "支付宝到账100万")
        s.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        s.pitchMultiplier = 1
        s.volume = 1
        s.rate = 0
        return s
    }()
//    mSampleRate: 22050.000000
//            mFormatID: 'lpcm'
//            mFormatFlags: 0xc
//            mBytesPerPacket: 2
//            mFramesPerPacket: 1
//            mBytesPerFrame: 2
//            mChannelsPerFrame: 1
//            mBitsPerChannel: 16
    func setUpVideo() {
        engine.attach(playerNode)
//        let avformt = AVAudioFormat(standardFormatWithSampleRate: 22050, channels: 1)
//        var asbd = AudioStreamBasicDescription()
//        asbd.mSampleRate = 22050.0
//        asbd.mFormatID = kAudioFormatLinearPCM
//        asbd.mFormatFlags = 0xc
//        asbd.mBytesPerPacket = 2
//        asbd.mFramesPerPacket = 1
//        asbd.mBytesPerFrame = 2
//        asbd.mChannelsPerFrame = 1
//        asbd.mBitsPerChannel = 16
//        let format = AVAudioFormat(streamDescription: &asbd)
//        let foramt = AVAudioFormat(commonFormat: AVAudioCommonFormat.pcmFormatInt16, sampleRate: 22050.0, channels: 1, interleaved: true)
        let layot = AVAudioChannelLayout(layoutTag:kAudioChannelLayoutTag_UseChannelDescriptions)!
        let fmt = AVAudioFormat(commonFormat: .pcmFormatInt16, sampleRate: 22050.0, interleaved: true, channelLayout: layot)
        engine.connect(engine.inputNode, to: engine.mainMixerNode, format: fmt )
//        engine.connect(engine.mainMixerNode, to: engine.outputNode, format: foramt)
        engine.prepare()
        do {
          try engine.start()
        } catch let error {
          print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        voice.delegate = self
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
//        self.engine.attach(self.playerNode)
//        self.engine.connect(self.playerNode, to: self.engine.outputNode, format: self.in)
//        setUpVideo()
    }

    @IBAction func speech(_ sender: UIButton) {
        let path = "/Users/macbookpro/Desktop/123/waf.caf"
//        self.voice.write(self.speech) {[weak self] (buffer) in
//            if let pcmBuffer = buffer as? AVAudioPCMBuffer, let strongSelf = self {
//
//            }
//        }
//        self.voice.speak(self.speech)
       try? self.saveAVSpeechUtteranceToFile(utterance: self.speech, fileURL: URL(fileURLWithPath: path))
    }
    
    func toNSData(PCMBuffer: AVAudioPCMBuffer) -> NSData {
        let format = PCMBuffer.format
        let channelCount = format.channelCount  // given PCMBuffer channel count is 1
        let channels = UnsafeBufferPointer(start: PCMBuffer.int16ChannelData, count: Int(channelCount))
        let mBytesPerFrame = format.streamDescription.pointee.mBytesPerFrame
        let ch0Data = NSData(bytes: channels[0], length:Int(PCMBuffer.frameCapacity * mBytesPerFrame))
        return ch0Data
    }
    
    func saveAVSpeechUtteranceToFile(utterance: AVSpeechUtterance, fileURL: URL) throws {
        let synthesizer = AVSpeechSynthesizer()
        
        var output: AVAudioFile?
        try? FileManager.default.removeItem(at: fileURL)
        synthesizer.write(utterance) { buffer in
            guard let pcmBuffer = buffer as? AVAudioPCMBuffer else {
                return
            }
            if pcmBuffer.frameLength == 0 {
                // no length
            }else{
                if output == nil {
                    output = try! AVAudioFile(forWriting: fileURL, settings: pcmBuffer.format.settings, commonFormat: .pcmFormatInt16, interleaved: false)
                }
                try! output!.write(from: pcmBuffer)
            }
        }
    }
    
}



