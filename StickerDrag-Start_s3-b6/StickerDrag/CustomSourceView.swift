//
//  CustomSourceView.swift
//  StickerDrag
//
//  Created by xdf_yanqing on 2020/5/5.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import Cocoa

class CustomSourceView: RoundedRectView {

  lazy var item: TidiFile = {
    let file = TidiFile(url: URL(string: "http://www.baidu.com")!, createdDateAttribute: Date(), modifiedDateAttribute: Date(), fileSizeAttribute: 1024)
    return file
  }()
  
  override func mouseDown(with event: NSEvent) {
    
    do {
//      let data = try PropertyListEncoder().encode(self.item)
//      let pasteboardItem = NSPasteboardItem()
//      pasteboardItem.setPropertyList(data, forType: TidiFile.type)
      let draggingItem = NSDraggingItem(pasteboardWriter: self.item)
      draggingItem.setDraggingFrame(self.bounds, contents:snapshot())
      beginDraggingSession(with: [draggingItem], event: event, source: self)
    } catch  {
      debugPrint("error" + error.localizedDescription)
      super.mouseDown(with: event)
    }

  }
}

// MARK: - NSDraggingSource
extension CustomSourceView: NSDraggingSource {
  
  func draggingSession(_ session: NSDraggingSession, sourceOperationMaskFor
    context: NSDraggingContext) -> NSDragOperation {
    
    switch(context) {
    case .outsideApplication:
      return NSDragOperation()
    case .withinApplication:
      return .generic
    }
  }
}


final class TidiFile : NSObject, Codable {
  
  var url : URL
  var createdDateAttribute : Date
  var modifiedDateAttribute : Date
  var fileSizeAttribute: Int
  
  init(url: URL, createdDateAttribute: Date, modifiedDateAttribute: Date, fileSizeAttribute: Int) {
    self.url = url
    self.createdDateAttribute = createdDateAttribute
    self.modifiedDateAttribute = modifiedDateAttribute
    self.fileSizeAttribute = fileSizeAttribute
  }
  
  convenience init?(pasteboardPropertyList propertyList: Any, ofType type: NSPasteboard.PasteboardType) {
    guard let data = propertyList as? Data,
      let tidi = try? PropertyListDecoder().decode(TidiFile.self, from: data) else { return nil }
    self.init(url: tidi.url, createdDateAttribute: tidi.createdDateAttribute, modifiedDateAttribute: tidi.modifiedDateAttribute, fileSizeAttribute: tidi.fileSizeAttribute)
  }
  override var description: String {
    return self.url.absoluteString
  }
  
  override var debugDescription: String {
    return self.url.absoluteString
  }
  
}

extension TidiFile : NSPasteboardWriting, NSPasteboardReading
{
  static let type  = NSPasteboard.PasteboardType(rawValue: "com.mycompany.myapp.myfiletype")

  
  public func writingOptions(forType type: NSPasteboard.PasteboardType, pasteboard: NSPasteboard) -> NSPasteboard.WritingOptions {
    return .promised
  }
  
  public func writableTypes(for pasteboard: NSPasteboard) -> [NSPasteboard.PasteboardType] {
    return [TidiFile.type]
  }
  
  public func pasteboardPropertyList(forType type: NSPasteboard.PasteboardType) -> Any? {
    if type == TidiFile.type {
      return try? PropertyListEncoder().encode(self)
    }
    return nil
  }
  
  public static func readableTypes(for pasteboard: NSPasteboard) -> [NSPasteboard.PasteboardType] {
    return [TidiFile.type]
  }
  
  public static func readingOptions(forType type: NSPasteboard.PasteboardType, pasteboard: NSPasteboard) -> NSPasteboard.ReadingOptions {
    return .asData
  }
  
  
}
