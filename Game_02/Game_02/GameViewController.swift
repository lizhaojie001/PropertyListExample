//
//  GameViewController.swift
//  Game_02
//
//  Created by xdf_yanqing on 2/3/21.
//

import SceneKit
import QuartzCore

class GameViewController: NSViewController {
    
    var scnView : SCNView!
    var scnScene : SCNScene!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupScene()
    }
    
    func setupView() {
        self.scnView = self.view as! SCNView
    }
    
    func setupScene() {
        scnScene = SCNScene()
        scnView.scene = scnScene
    }
}
