//
//  ViewController.swift
//  PlayerViewLayer
//
//  Created by xdf_yanqing on 2021/4/7.
//

import UIKit
import AVKit



class ViewController: UIViewController {

    lazy var window: UIWindow = {
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        window.backgroundColor = UIColor.blue
        let root = UIViewController()
        root.view.backgroundColor = UIColor.red
        window.rootViewController = root
        return window
    }()
    
    var pictureInPictureController: AVPictureInPictureController?
    var pipPossibleObservation : NSKeyValueObservation?
    @IBOutlet weak var pipButton: UIButton!
    let playerLayer = AVPlayerLayer()
    lazy var player: AVPlayer = {
//        https://vd2.bdstatic.com/mda-kjkpvdnzxngm6s5s/sc/cae_h264_clips/1603271118/mda-kjkpvdnzxngm6s5s.mp4
        let path = Bundle.main.path(forResource: "1920x1080", ofType: "mp4")
        let player = AVPlayer(url: URL(fileURLWithPath: path!))
        return player
    }()
    
    @IBAction func avPlayerController(_ sender: Any) {
        self.present(self.avplayerController, animated: true, completion: nil)
    }
    lazy var avplayerController: AVPlayerViewController = {
        let controller = AVPlayerViewController()
        return controller
    }()
    
    @IBAction func startPip(_ sender: Any) {
        if pictureInPictureController?.isPictureInPictureActive == true {
            pictureInPictureController?.stopPictureInPicture()
        } else {
            pictureInPictureController?.startPictureInPicture()
//            pictureInPictureController?.playerLayer.player = nil
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let video = UIView()
        video.backgroundColor = .black
        video.frame = CGRect(x: 20, y: 200, width: 300, height: 200)
        view.addSubview(video)
        self.playerLayer.setAffineTransform(CGAffineTransform.init(rotationAngle: CGFloat.pi))
        self.playerLayer.frame = video.bounds
        video.layer.addSublayer(self.playerLayer)
        self.playerLayer.player = self.player
        let startImage = AVPictureInPictureController.pictureInPictureButtonStartImage
        let stopImage = AVPictureInPictureController.pictureInPictureButtonStopImage
        var frame = pipButton.frame
        frame.size = CGSize(width: 50, height: 50)
        pipButton.frame = frame
        pipButton.setImage(startImage, for: .normal)
        pipButton.setImage(stopImage, for: .selected)
        // Do any additional setup after loading the view.
        setupPictureInPicture()
        
      
    }

    
    @IBAction func openAcess(_ sender: Any) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord)
            try AVAudioSession.sharedInstance().setActive(true, options: [])
            self.pictureInPictureController?.playerLayer.player = self.player
        } catch  {
            debugPrint("打开权限失败")
        }
    }
     
    @IBAction func rotate(_ sender: Any) {
        let transform = self.playerLayer.affineTransform().rotated(by: CGFloat.pi/2)
        self.playerLayer.setAffineTransform(transform)
    }
    
    func setupPictureInPicture() {
        // Ensure PiP is supported by current device.
        if AVPictureInPictureController.isPictureInPictureSupported() {
            // Create a new controller, passing the reference to the AVPlayerLayer.
            pictureInPictureController = AVPictureInPictureController(playerLayer: playerLayer)
            pictureInPictureController?.delegate = self
            pipPossibleObservation = pictureInPictureController?.observe(\AVPictureInPictureController.isPictureInPicturePossible,
                                                                        options: [.initial, .new]) { [weak self] _, change in
                // Update the PiP button's enabled state.
                self?.pipButton.isEnabled = change.newValue ?? false
            }
        } else {
            // PiP isn't supported by the current device. Disable the PiP button.
            pipButton.isEnabled = false
        }
    }

}

extension ViewController : AVPictureInPictureControllerDelegate {
    
    var platformAdapter: AnyObject? {
        return pictureInPictureController?.value(forKeyPath: "platformAdapter") as? AnyObject
    }
    
    //点击pip回到应用
    func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController,
                                    restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        // Restore user interface
        completionHandler(true)
    }
    
    func pictureInPictureControllerDidStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        debugPrint("开始")
        debugPrint(pictureInPictureController.getAllProperties())
        debugPrint(pictureInPictureController.properties_aps())
//        let AVPlayerController = NSClassFromString("AVPlayerController")
//
//        let  sublayers = pictureInPictureController.properties_aps()["playerController"] as? AnyObject
//        debugPrint(sublayers?.properties_aps())
//
//        debugPrint(pictureInPictureController.printMothList())
        
        debugPrint(pictureInPictureController.value(forKeyPath: "platformAdapter") as? AnyObject)
       debugPrint(window)
        platformAdapter?.perform(NSSelectorFromString("setSourceWindowWhenPictureInPictureStarted:"), with: window)
        debugPrint(platformAdapter?.value(forKeyPath: "sourceWindowWhenPictureInPictureStarted"))
        let layoutCheckTimer =  platformAdapter?.value(forKeyPath: "layoutCheckTimer") as? AnyObject
//        layoutCheckTimer?.perform(NSSelectorFromString("invalidate"))
        platformAdapter?.setValue(nil, forKeyPath: "layoutCheckTimer")
//        let platformAdapter = pictureInPictureController.value(forKeyPath: "platformAdapter") as? AnyObject
        platformAdapter?.setValue(CGRect(x: 0, y: 0, width: 200, height: 500), forKeyPath: "videoRectInScreen")
    }
    
    @objc func setSourceWindowWhenPictureInPictureStarted(_ window : UIWindow)  {
        
    }
    
    func pictureInPictureControllerWillStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        pictureInPictureController.setValue(1, forKeyPath: "controlsStyle")  //1 . 去掉控制界面
        pictureInPictureController.playerLayer.bounds = CGRect(x: 0, y: 0, width: 200, height: 400)
       
        debugPrint("即将开始")
    }
    
    func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController, failedToStartPictureInPictureWithError error: Error) {
        debugPrint("失败: ",error)
    }
    
    func pictureInPictureControllerDidStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        debugPrint("结束画中画")
    }
    
    func pictureInPictureControllerWillStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        debugPrint("即将结束")
    }
}
 

class SPAVPictureInPictureController: AVPictureInPictureController {
    convenience init(_ playerView : UIView) {
        self.init()
    }
}
