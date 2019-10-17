//
//  ViewController.swift
//  CollectionView
//
//  Created by xdf_yanqing on 2019/8/27.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    static let identifier = NSUserInterfaceItemIdentifier("item")
    var lastIndexPath : IndexPath?
    lazy var apps: [App] = {
        let apps = [App]()
        return apps
    }()
    
    convenience init() {
        self.init()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setData()
        setupView()
        // Do any additional setup after loading the view.
        
    }
    
    func setData() {
        guard let applicationPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.applicationDirectory, FileManager.SearchPathDomainMask.systemDomainMask, true).first else { return  }
        var apps = try? FileManager.default.contentsOfDirectory(atPath: applicationPath).filter({ (item) -> Bool in
            return item.contains(".app")
        }).map({ (appName) -> App in
            let infoPlist = applicationPath.appendingFormat("/%@/Contents/info.plist", appName)
            guard let dict = NSDictionary.init(contentsOfFile: infoPlist) else {return App()}
            guard var icon = dict["CFBundleIconFile"] as? String else { return App()}
            if !icon.contains("icns") { icon = icon + ".icns"}
            let imagePath =  applicationPath.appendingFormat("/%@/Contents/Resources/%@", appName,icon)
            let app = App()
            app.appName = appName
            app.iconName = icon
            app.iconPath = imagePath
            return app
        })
        guard let appIconPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first else { return }
        apps?.forEach({ (app) in
            guard var imageName = app.iconName else { return }
            guard let path = app.iconPath else { return }
            guard let appName = app.appName else { return }
            app.pngPath = appIconPath.appendingFormat("/%@.png", appName)
            let arg : [String] = ["-s","format","png" ,"-z","256","256",path , "--out"  ,  app.pngPath!]
            let a =  Script.runScript(path: "/usr/bin/sips", arguments: arg)
            debugPrint(a)
        })
        apps = apps?.filter({ (app) -> Bool in
            return app.iconPath != nil
        })
        
        self.apps.removeAll()
        self.apps.append(contentsOf: apps!)
 
    }
    
    
    
    
    

    func setupView(){
        let scroll = NSScrollView.init(frame: self.view.bounds)
        scroll.drawsBackground = false
        scroll.contentView.copiesOnScroll = false
        scroll.contentView.backgroundColor = NSColor.clear
        scroll.borderType = .noBorder
        scroll.hasVerticalRuler = false
        scroll.hasHorizontalRuler = false
        scroll.autoresizingMask = [.width,.height]
        let contentSize = scroll.contentSize
        let collection = NSCollectionView(frame: NSRect(origin: CGPoint.zero, size:contentSize ))
        let layout = NSCollectionViewFlowLayout()
        layout.itemSize = NSSize(width: 60, height: 60)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.sectionInset = NSEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        collection.collectionViewLayout = layout
        collection.isSelectable = true
        collection.register(CollectionViewItem.self, forItemWithIdentifier: ViewController.identifier)
        scroll.documentView = collection
        collection.delegate = self
        collection.dataSource = self
        self.view.addSubview(scroll)
        
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

extension ViewController :  NSCollectionViewDelegate , NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.apps.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
         let item = collectionView.makeItem(withIdentifier: ViewController.identifier, for: indexPath) as! CollectionViewItem
        item.app = self.apps[indexPath.item]
        return item
    }
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        debugPrint(indexPaths)
        if let indexPath = self.lastIndexPath {
            collectionView.deselectItems(at: [indexPath])
//            let item = collectionView.item(at: indexPath)
//            item?.view.layer?.backgroundColor = NSColor.red.cgColor
        }
        
        indexPaths.forEach { (indexPath) in
//            let item = collectionView.item(at: indexPath)
//            item?.view.layer?.backgroundColor = NSColor.blue.cgColor
            self.lastIndexPath = indexPath
        }
        
        guard let item = self.lastIndexPath?.item else { return }
        let app = self.apps[item]
        guard let appName = app.appName else { return }
        guard  let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.applicationDirectory, FileManager.SearchPathDomainMask.systemDomainMask, true).first else { return }
        let application = path + "/" +  appName
        Script.runScript(path: "/usr/bin/open", arguments: ["-n", application])
    }
    
}


class App: NSObject {
    var iconName : String?
    var appName : String?
    var iconPath : String?
    var pngPath : String?
}
