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
    let collectionView = NSCollectionView(frame: CGRect(origin: CGPoint.zero, size: proxy.size))
    collectionView.delegate = context.coordinator
    collectionView.dataSource = context.coordinator
    collectionView.register(HostingCellView.self, forItemWithIdentifier: Cell.reuseIdentifier)

    let layout = NSCollectionViewFlowLayout()
    layout.minimumLineSpacing = 4
    collectionView.collectionViewLayout = layout



//    let scrollView = NSScrollView(frame: view.bounds)
//    scrollView.documentView = collectionView
//    view.addSubview(scrollView)
    
    configureCollectionView(collectionView)

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
    // 1
    let flowLayout = NSCollectionViewFlowLayout()
    flowLayout.itemSize = NSSize(width: 160.0, height: 140.0)
    flowLayout.sectionInset = NSEdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 20.0)
    flowLayout.minimumInteritemSpacing = 20.0
    flowLayout.minimumLineSpacing = 20.0
    flowLayout.sectionHeadersPinToVisibleBounds = true
    collectionView.collectionViewLayout = flowLayout
//    collectionView.wantsLayer = true
//    collectionView.layer?.backgroundColor = NSColor.black.cgColor
  }
  
  func updateNSView(_ nsView: NSView, context: Context) {
    print("updateNSView")
  }

  func makeCoordinator() -> Coordinator {
    print("makeCoordinator")
    return Coordinator(self)
  }

  class Coordinator: NSObject, NSCollectionViewDelegate, NSCollectionViewDataSource {

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
      item.setView(Cell())
      return item
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
