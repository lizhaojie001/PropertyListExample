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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        // Do any additional setup after loading the view.
        
        setData()
    }
    
    func setData() {
        guard let applicationPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.applicationDirectory, FileManager.SearchPathDomainMask.systemDomainMask, true).first else { return  }
        let paths = try? FileManager.default.contentsOfDirectory(atPath: applicationPath).filter({ (item) -> Bool in
            return item.contains(".app")
        })
        let imagePaths = paths?.map({ (item) -> [String : String] in
            let imageName = item.replacingOccurrences(of: ".app", with: "")
            let imagePath =  applicationPath.appendingFormat("/%@/Contents/Resources/%@.icns", item,imageName)
            if FileManager.default.fileExists(atPath: imagePath) {
                return [imagePath : imageName ]
            }
            return [applicationPath.appendingFormat("/%@/Contents/Resources/AppIcon.icns", item) : imageName]
        })
        let appIconPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        imagePaths?.forEach({ (dict) in
            let path = dict.keys.first
            let imageName = dict.values.first
            let arg = " -s format png -z 256 256 " + "\"\(path!)\"" + " --out " + "\"\(appIconPath?.appendingFormat("%@.png", imageName!))\""
            Script.runScript(path: "/usr/bin/sips", arguments: [arg])
        })
   
        
    }
    
    
    

    func setupView(){
        let scroll = NSScrollView.init(frame: NSRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 360, height: 120)))
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
        return 10
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
         let item = collectionView.makeItem(withIdentifier: ViewController.identifier, for: indexPath)
        return item
    }
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        debugPrint(indexPaths)
        if let indexPath = self.lastIndexPath {
            collectionView.deselectItems(at: [indexPath])
            let item = collectionView.item(at: indexPath)
            item?.view.layer?.backgroundColor = NSColor.red.cgColor
        }
        
        indexPaths.forEach { (indexPath) in
            let item = collectionView.item(at: indexPath)
            item?.view.layer?.backgroundColor = NSColor.blue.cgColor
            self.lastIndexPath = indexPath
        }
    }
    
}
