//
//  ViewController.swift
//  Recorder
//
//  Created by xdf_yanqing on 2019/12/30.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa
import AVFoundation
class ViewController: NSViewController {

//    var recoder =  XYRecorder()//MLAudioBufferRecorder()
    var timer : Timer?
    lazy var recoder: AVAudioPlayer = {
        let temp = Bundle.main.path(forResource: "add", ofType: "m4a")
        let recoder = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: temp!))
        recoder.isMeteringEnabled = true
        recoder.delegate = self
        return recoder
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recoder.prepareToPlay()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func stop(_ sender: Any) {
//        recoder.stopRecord()
//        recoder.stop()
//        Audio.sharedAudioManager().stop()
        self.recoder.stop()
        self.timer?.invalidate()
        self.timer = nil
    }
    
    @IBAction func start(_ sender: Any) {
//        recoder.startRecord { (isStart) in
//            debugPrint(isStart)
//        }
//        Audio.sharedAudioManager().start()
        self.recoder.play()
        let timer = Timer(timeInterval: 1, repeats: true) {[weak self] (timer) in
            self?.recoder.updateMeters()
            debugPrint(self?.recoder.peakPower(forChannel: 1),self?.recoder.numberOfLoops)
        }
        self.timer = timer
        timer.fire()
        RunLoop.current.add(timer, forMode: .common)
    }
}

extension ViewController : AVAudioPlayerDelegate {
    
}
