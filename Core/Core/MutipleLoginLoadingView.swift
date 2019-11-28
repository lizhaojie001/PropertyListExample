//
//  MutipleLoginLoadingView.swift
//  sac_mac
//
//  Created by xdf_yanqing on 2019/11/20.
//  Copyright © 2019 SAC. All rights reserved.
//

import Cocoa

class MutipleLoginLoadingView: NSView {

    private weak var workItem : DispatchWorkItem?
    
    private lazy var imageView : NSImageView = {
        let  imageView = NSImageView(frame: NSRect(origin: CGPoint(x: bounds.midX - 23, y: bounds.midY - 23), size: CGSize(width: 46, height: 46)))
        imageView.image = NSImage(named: "states_public_loading")
        imageView.wantsLayer = true
        return imageView
    }()
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        if let _ = self.superview {
            setupView()
        }
    }
    
    private func setupView() {
        self.wantsLayer = true
        let  bgImageView = NSImageView(frame: NSRect(origin: CGPoint.zero, size: CGSize(width: 120, height: 120)))
        bgImageView.image = NSImage(named: "bg_toast")
        bgImageView.autoresizingMask = [.width,.height]
        addSubview(bgImageView)
//        bgImageView.snp.makeConstraints { (maker) in
//            maker.center.equalToSuperview()
//            maker.height.width.equalToSuperview()
//        }
//        imageView.frame.center = self.bounds.center
        bgImageView.addSubview(imageView)
//        imageView.snp.makeConstraints { (maker) in
//            maker.center.equalToSuperview()
//            maker.height.width.equalTo(46)
//        }
    }
    
    public func start() {
        self.isHidden = false
        roationImageView()
    }
    
    public func stop() {
//        self.isHidden = true
//        self.imageView.layer?.removeAnimation(forKey: "transform.rotation.z")
//        debugPrint("停止loading动画")
    }
    public func showError() {
        self.imageView.image = NSImage(named: "states_public_loading-fail")
        let item = DispatchWorkItem {
            self.stop()
        }
        self.workItem = item
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: item)
    }
    
    
    @objc private func roationImageView() {
//        imageView.layer?.position = CGPoint(x: bounds.midX - 23, y: bounds.midY - 23)
//        self.imageView.layer?.anchorPoint = NSPoint(x: 0.5, y: 0.5)
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.duration = 2
        animation.repeatCount = MAXFLOAT
        animation.fromValue = 0
        animation.toValue = 2 * Double.pi
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        self.imageView.layer?.add(animation, forKey: animation.keyPath)
        debugPrint(self.imageView.layer?.anchorPoint, self.layer?.anchorPoint)
//        debugPrint(imageView.layer?.position , self.bounds.center)
    }

    deinit {
        self.workItem?.cancel()
    }
    
    
//    private func setPosition:(CGPoint)point atAnchorPoint:(CGPoint)anchorPoint
//    {
//    CGFloat x = point.x - anchorPoint.x * self.width;
//    CGFloat y = point.y - anchorPoint.y * self.height;
//    [self setOrigin:CGPointMake(x, y)];
//    }
    
    override func layout() {
        imageView.frame = NSRect(origin: CGPoint(x: bounds.midX - 23, y: bounds.midY - 23), size: CGSize(width: 46, height: 46))
//        imageView.layer?.position = CGPoint(x: bounds.midX - 23, y: bounds.midY - 23)
        self.imageView.layer?.anchorPoint = NSPoint(x: 0.5, y: 0.5)
        super.layout()
    }
  
}

