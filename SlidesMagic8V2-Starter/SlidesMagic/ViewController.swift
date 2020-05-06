/*
* ViewController.swift
* SlidesMagic
*
* Created by Gabriel Miro on Oct 2016.
* Copyright (c) 2016 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import Cocoa
import SnapKit
class ViewController: NSViewController {
  
  let imageDirectoryLoader = ImageDirectoryLoader()

  weak var collectionView : NSCollectionView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let initialFolderUrl = URL(fileURLWithPath: "/Library/Desktop Pictures", isDirectory: true)
    imageDirectoryLoader.loadDataForFolderWithUrl(initialFolderUrl)
    setupView()
  }
  
  
  func setupView() {
    
    let scroll = NSScrollView(frame:NSRect.zero)
    scroll.backgroundColor = NSColor.clear
    scroll.drawsBackground = false
    scroll.contentView.copiesOnScroll = false
    scroll.contentView.drawsBackground = false
    scroll.borderType = .noBorder
    scroll.hasHorizontalScroller = true
    scroll.hasVerticalScroller = false
    scroll.horizontalScroller?.alphaValue = 0.0
    let contentSize = NSSize(width: 100 , height: 240)
    let collection = NSCollectionView(frame: NSRect(origin: CGPoint.zero, size:contentSize ))
    collection.backgroundColors = [.clear]
    collection.backgroundView?.layer?.backgroundColor = NSColor.clear.cgColor
    let layout = NSCollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.itemSize = NSSize(width: 100, height: 100)
    layout.minimumLineSpacing = 30
    layout.minimumInteritemSpacing = 2
    layout.sectionInset = NSEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    collection.collectionViewLayout = layout
    collection.isSelectable = true
    collection.register(CollectionViewItem.self, forItemWithIdentifier: CollectionViewItem.identifier)
    scroll.documentView = collection
    collection.delegate = self
    collection.dataSource = self
    self.view.addSubview(scroll)
    self.collectionView = collection
//    self.scrollView = scroll
    scroll.snp.makeConstraints { (maker) in
      maker.center.height.width.equalToSuperview()
    }
  }
  
  func loadDataForNewFolderWithUrl(_ folderURL: URL) {
    imageDirectoryLoader.loadDataForFolderWithUrl(folderURL)
  }


}


extension ViewController : NSCollectionViewDelegate,NSCollectionViewDataSource {
  func numberOfSections(in collectionView: NSCollectionView) -> Int {
    return imageDirectoryLoader.numberOfSections
  }
  
  func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageDirectoryLoader.numberOfItemsInSection(section)
  }
  
  func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
    let item = collectionView.makeItem(withIdentifier: CollectionViewItem.identifier, for: indexPath)
    guard let collectionItem = item as? CollectionViewItem else{ return item }
    collectionItem.textTF.stringValue = "12345"
    return collectionItem
  }
  
  
}
