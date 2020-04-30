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

class ImageSourceView: RoundedRectView {
  //逻辑图 https://koenig-media.raywenderlich.com/uploads/2016/07/dragging-session-macro2.png
  override func mouseDown(with event: NSEvent) {
    let pasete = NSPasteboardItem()
    pasete.setDataProvider(self, forTypes: [.tiff])
    let dragingItem = NSDraggingItem(pasteboardWriter: pasete)
    dragingItem.setDraggingFrame(self.bounds, contents: snapshot())
//    dragingItem.draggingFrame = self.bounds
//    let comonent1 = NSDraggingImageComponent(key: NSDraggingItem.ImageComponentKey.icon)
//    comonent1.contents = snapshot()
//    comonent1.frame =  NSRect( x: 0 , y: 0 , width: 100 , height: 50)
//    let comonent2 = NSDraggingImageComponent(key: NSDraggingItem.ImageComponentKey.label)
//    comonent2.contents = snapshot()
//    comonent2.frame =  NSRect( x: 0 , y: 0 , width: 100 , height: 50)
//    dragingItem.imageComponentsProvider = {
//      return [comonent2 , comonent1]
//    }
    beginDraggingSession(with: [dragingItem], event: event, source: self)
  }

}

extension ImageSourceView : NSDraggingSource  {
  func draggingSession(_ session: NSDraggingSession, sourceOperationMaskFor context: NSDraggingContext) -> NSDragOperation {
    return .generic
  }
}

extension ImageSourceView : NSPasteboardItemDataProvider {
  func pasteboard(_ pasteboard: NSPasteboard?, item: NSPasteboardItem, provideDataForType type: NSPasteboard.PasteboardType) {
    //return image data
    if let paste = pasteboard , type == .tiff , let image = NSImage(named: "unicorn") {
      let finalImage = image.tintedImageWithColor(NSColor.randomColor())
      let tiffData = finalImage.tiffRepresentation
      paste.setData(tiffData, forType: type)
    }
  }
  
  func pasteboardFinishedWithDataProvider(_ pasteboard: NSPasteboard) {
    debugPrint(#function)
  }
}


