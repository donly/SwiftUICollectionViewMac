//
//  GridView.swift
//  SwiftUICollectionViewMac
//
//  Created by Don on 27/10/2020.
//

import SwiftUI
import AppKit

struct Cell: View {
  static let reuseIdentifier = NSUserInterfaceItemIdentifier("HostingCellView")
  var body: some View {
    Text("Cell")
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.red)
  }
}

//struct GridView: NSViewControllerRepresentable {
//  typealias NSViewControllerType = GridViewController
//
//  func makeNSViewController(context: Context) -> GridViewController {
//    let viewController = GridViewController()
//    return viewController
//  }
//
//  func updateNSViewController(_ nsViewController: GridViewController, context: Context) {
//    print("updateNSViewController")
//  }
//
//  func makeCoordinator() -> () {
//    print("makeCoordinator")
//  }
//}

struct GridView: NSViewRepresentable {
  typealias NSViewType = NSView
  let proxy: GeometryProxy
  var numbers: [Int]

  func makeNSView(context: Context) -> NSView {
    print("makeNSView")
//    let view = NSView(frame: CGRect(origin: CGPoint.zero, size: proxy.size))
    let collectionView = NSCollectionView(frame: CGRect(origin: CGPoint.zero, size: proxy.size))
    collectionView.delegate = context.coordinator
    collectionView.dataSource = context.coordinator
//    let scrollView = NSScrollView(frame: view.bounds)
//    scrollView.documentView = collectionView
//    view.addSubview(scrollView)
//
    configureCollectionView(collectionView)
    registerForDragAndDrop(collectionView)
    
//    let dataSource = NSCollectionViewDiffableDataSource<Int, Int>(collectionView: view) { (view, indexPath, sectionIndex) -> NSCollectionViewItem? in
//      guard let item = view.makeItem(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? HostingCellView else {
//        fatalError()
//      }
//      item.setView(Cell())
//      return item
//    }
//
//    context.coordinator.dataSource = dataSource
//
//    var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
//    snapshot.appendSections([0])
//    snapshot.appendItems([1, 2, 3], toSection: 0)
//    dataSource.apply(snapshot, animatingDifferences: true)

    return collectionView
  }
  
  fileprivate func configureCollectionView(_ collectionView: NSCollectionView) {
    collectionView.register(HostingCellView.self, forItemWithIdentifier: Cell.reuseIdentifier)
    
    let flowLayout = NSCollectionViewFlowLayout()
    flowLayout.itemSize = NSSize(width: 160.0, height: 140.0)
    flowLayout.sectionInset = NSEdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 20.0)
    flowLayout.minimumInteritemSpacing = 20.0
    flowLayout.minimumLineSpacing = 20.0
    flowLayout.sectionHeadersPinToVisibleBounds = true
    collectionView.collectionViewLayout = flowLayout
//    collectionView.wantsLayer = true
//    collectionView.layer?.backgroundColor = NSColor.black.cgColor
    collectionView.isSelectable = true
  }
  
  func registerForDragAndDrop(_ collectionView: NSCollectionView) {
//    collectionView.registerForDraggedTypes([NSPasteboard.PasteboardType.URL])
    collectionView.registerForDraggedTypes([NSPasteboard.PasteboardType(kUTTypeItem as String)])
    collectionView.setDraggingSourceOperationMask(.move, forLocal: true)
//    collectionView.setDraggingSourceOperationMask(NSDragOperation.every, forLocal: false)
  }
  
  func updateNSView(_ nsView: NSView, context: Context) {
    print("updateNSView")
  }

  func makeCoordinator() -> Coordinator {
    print("makeCoordinator")
    return Coordinator(self)
  }

  class Coordinator: NSObject, NSCollectionViewDelegate, NSCollectionViewDataSource {
    var indexPathsOfItemsBeingDragged: Set<IndexPath> = []
    
    let view: GridView
//    var dataSource: NSCollectionViewDiffableDataSource<Int, Int>? = nil
    init(_ view: GridView) {
      self.view = view
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
      return view.numbers.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
      let item = collectionView.makeItem(
        withIdentifier: Cell.reuseIdentifier,
          for: indexPath
        ) as! HostingCellView
//      item.setView(Cell())
      return item
    }
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
      print("didSelectItemsAt")
    }
    
    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
      print("didDeselectItemsAt")
    }
    
    func collectionView(_ collectionView: NSCollectionView, canDragItemsAt indexes: IndexSet, with event: NSEvent) -> Bool {
      print("canDragItemsAt")
      return true
    }
    
    func collectionView(_ collectionView: NSCollectionView, pasteboardWriterForItemAt indexPath: IndexPath) -> NSPasteboardWriting? {
      
      let retorno = NSPasteboardItem()
      
//      var data: Data?
//      do {
//        try data = produtoLoja?.fotos[indexPath.item].foto?.getData()
//      } catch {
//
//      }
      
//      retorno.setData(data!, forType: NSPasteboard.PasteboardType(kUTTypeItem as String))
      retorno.setData(Data("test".utf8), forType: NSPasteboard.PasteboardType(kUTTypeItem as String))
      
      return retorno
    }
    
    func collectionView(_ collectionView: NSCollectionView, draggingSession session: NSDraggingSession, willBeginAt screenPoint: NSPoint, forItemsAt indexPaths: Set<IndexPath>) {
      print("draggingSession")
      indexPathsOfItemsBeingDragged = indexPaths
    }
    
    func collectionView(_ collectionView: NSCollectionView, draggingSession session: NSDraggingSession, endedAt screenPoint: NSPoint, dragOperation operation: NSDragOperation) {
      indexPathsOfItemsBeingDragged = []
    }
    
    func collectionView(_ collectionView: NSCollectionView, validateDrop draggingInfo: NSDraggingInfo, proposedIndexPath proposedDropIndexPath: AutoreleasingUnsafeMutablePointer<NSIndexPath>, dropOperation proposedDropOperation: UnsafeMutablePointer<NSCollectionView.DropOperation>) -> NSDragOperation {
      if proposedDropOperation.pointee == NSCollectionView.DropOperation.on {
        proposedDropOperation.pointee = NSCollectionView.DropOperation.before
      }
      
      print("validateDrop")
      if indexPathsOfItemsBeingDragged.count == 0 {
        return NSDragOperation.copy
      } else {
        return NSDragOperation.move
  //      let sectionOfItemBeingDragged = indexPathsOfItemsBeingDragged.first!.section
  //      let proposedDropsection = proposedDropIndexPath.pointee.section
  //      if sectionOfItemBeingDragged == proposedDropsection && indexPathsOfItemsBeingDragged.count == 1 {
  //        return NSDragOperation.move
  //      } else {
  //        return NSDragOperation(rawValue: 0)
  //      }
      }
    }
    
    func collectionView(_ collectionView: NSCollectionView, acceptDrop draggingInfo: NSDraggingInfo, indexPath: IndexPath, dropOperation: NSCollectionView.DropOperation) -> Bool {
      
      var retorno = true
      
      if indexPathsOfItemsBeingDragged.count == 1 {
        for indice in indexPathsOfItemsBeingDragged {
          collectionView.animator().moveItem(at: indice, to: (indexPath.item <= indice.item) ? indexPath : (IndexPath(item: indexPath.item - 1, section: 0)))
        }
      } else {
        retorno = false
      }
      
      return retorno
    }
  }
}

//struct CollectionView: View {
//  var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
//  var body: some View {
//    VStack {
//      GridView(numbers: numbers)
//    }
//  }
//}
//
//struct GridView_Previews: PreviewProvider {
//  static var previews: some View {
//    CollectionView()
//  }
//}
