//
//  ViewController.swift
//  tabController_demo
//
//  Created by xdf_yanqing on 2020/5/6.
//  Copyright © 2020 xdf_yanqing. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var index = 0
    var tab : NSTabViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
           let first = FirstController()
                let second = SecondController()
                let tabController = NSTabViewController()
                tabController.tabView.tabViewType = .noTabsNoBorder
                tabController.tabView.tabViewBorderType = .none
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
                tabController.view.frame = NSRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 100))
                self.view.addSubview(tabController.view)
                self.tab = tabController
                
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func touch(_ sender: Any) {
        let index = self.index == 0 ? 1 : 0
        tab?.tabView.selectTabViewItem(at: index)
        self.index = index
    }
    
    override func transition(from fromViewController: NSViewController, to toViewController: NSViewController, options: NSViewController.TransitionOptions = [], completionHandler completion: (() -> Void)? = nil) {
        super.transition(from: fromViewController, to: toViewController, options: options, completionHandler: completion)
        debugPrint(fromViewController,toViewController)
    }
}

