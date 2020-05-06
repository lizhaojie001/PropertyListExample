//
//  ViewController.swift
//  tabController_demo
//
//  Created by xdf_yanqing on 2020/5/6.
//  Copyright © 2020 xdf_yanqing. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func touch(_ sender: Any) {
        let first = FirstController()
        let second = SecondController()
        let tabController = NSTabViewController()
//        tabController.tabView.tabViewType = .noTabsNoBorder
//        tabController.tabView.tabViewBorderType = .none
//        tabController.addChild(first)
//        tabController.addChild(second)
        tabController.tabStyle = .unspecified
        tabController.transitionOptions = [.slideForward,.slideBackward]
        tabController.canPropagateSelectedChildViewControllerTitle = true
        let item1 = NSTabViewItem(viewController: first)
        item1.label = "1"
        let item2 = NSTabViewItem(viewController: second)
        item2.label = "2"
        tabController.tabViewItems = [item1,item2]
        self.presentAsModalWindow(tabController)
    }
    
    override func transition(from fromViewController: NSViewController, to toViewController: NSViewController, options: NSViewController.TransitionOptions = [], completionHandler completion: (() -> Void)? = nil) {
        super.transition(from: fromViewController, to: toViewController, options: options, completionHandler: completion)
        debugPrint(fromViewController,toViewController)
    }
}

