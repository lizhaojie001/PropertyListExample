/*
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

protocol DestinationViewDelegate {
  func processImageURLs(_ urls: [URL], center: NSPoint)
  func processImage(_ image: NSImage, center: NSPoint)
  func processAction(_ action: String, center: NSPoint)
}

class DestinationView: NSView {
  
  enum Appearance {
    static let lineWidth: CGFloat = 10.0
  }
  
  var delegate: DestinationViewDelegate?
  
  override func awakeFromNib() {
    if #available(OSX 10.13, *) {
      setup()
    } else {
      // Fallback on earlier versions
    }
  }
  
  let filteringOptions = [NSPasteboard.ReadingOptionKey.urlReadingContentsConformToTypes : NSImage.imageTypes]
  
  @available(OSX 10.13, *)
  var acceptableTypes: [NSPasteboard.PasteboardType] { return [.fileURL,.URL,.tiff,NSPasteboard.PasteboardType(rawValue: SparkleDrag.type)] }
  
  @available(OSX 10.13, *)
  func setup() {
      registerForDraggedTypes(acceptableTypes)
  }
  
  override func draw(_ dirtyRect: NSRect) {
    if isReceivingDrag {
      NSColor.red.set()
      let path = NSBezierPath(rect:bounds)
      path.lineWidth = Appearance.lineWidth
      path.stroke()
    }
  }
  
  //we override hitTest so that this view which sits at the top of the view hierachy
  //appears transparent to mouse clicks
  override func hitTest(_ aPoint: NSPoint) -> NSView? {
    return nil
  }
  
  
  func shouldAllowDrag(_ draggingInfo: NSDraggingInfo) -> Bool {
    
    var canAccept = false
    
    //2.
    let pasteBoard = draggingInfo.draggingPasteboard
    
    if (pasteBoard.availableType(from: [NSPasteboard.PasteboardType(rawValue: SparkleDrag.type)]) != nil) {
      return true
    }
    //3.
    if pasteBoard.canReadObject(forClasses: [NSURL.self,NSImage.self], options: filteringOptions) {
      canAccept = true
    }
    return canAccept
    
  }
  
  override var isFlipped: Bool {
    return true
  }

  var isReceivingDrag = false {
    didSet {
      needsDisplay = true
    }
  }
  override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
    let allow = self.shouldAllowDrag(sender)
    isReceivingDrag = allow
    return allow ? .copy : NSDragOperation()
  }
  
  override func draggingExited(_ sender: NSDraggingInfo?) {
    isReceivingDrag = false
  }
  
  override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
    return self.shouldAllowDrag(sender)
  }
  
  override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
    isReceivingDrag = false
    let paste = sender.draggingPasteboard
    let point = convert(sender.draggingLocation, to: nil)
    if let urls = paste.readObjects(forClasses: [NSURL.self], options: filteringOptions) as? [URL] , urls.count > 0 {
      delegate?.processImageURLs(urls, center: point)
      return true
    } else if let image = NSImage(pasteboard: paste) {
      delegate?.processImage(image, center: point)
      return true
    } else if let types = paste.types, types.contains(NSPasteboard.PasteboardType(rawValue: SparkleDrag.type)),
      let action = paste.string(forType: NSPasteboard.PasteboardType(rawValue: SparkleDrag.type)) {
      delegate?.processAction(action, center:point)
      return true
    }
    
    var isOk  = false
    sender.enumerateDraggingItems(options: NSDraggingItemEnumerationOptions.concurrent, for: self, classes: [NSPasteboardItem.self], searchOptions: [:]) { (dragItem, index, stop) in
      debugPrint(dragItem.imageComponents,index,stop.pointee.boolValue)
      for  compoent in dragItem.imageComponents ?? [] {
        guard let image = compoent.contents as? NSImage else { return }
        self.delegate?.processImage(image, center: point)
        isOk = true
      }
    }
    return isOk
    
  }
}

