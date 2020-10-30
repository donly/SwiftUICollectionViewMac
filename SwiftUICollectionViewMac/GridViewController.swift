//
//  GridViewController.swift
//  SwiftUICollectionViewMac
//
//  Created by Don on 30/10/2020.
//

import Cocoa

class GridViewController: NSViewController {
  
  @IBOutlet weak var collectionView: NSCollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
  }
  
  fileprivate func configureCollectionView() {
    // 1
    let flowLayout = NSCollectionViewFlowLayout()
    flowLayout.itemSize = NSSize(width: 60.0, height: 40.0)
    flowLayout.sectionInset = NSEdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 20.0)
    flowLayout.minimumInteritemSpacing = 20.0
    flowLayout.minimumLineSpacing = 20.0
    flowLayout.sectionHeadersPinToVisibleBounds = true
    collectionView.collectionViewLayout = flowLayout
//    collectionView.wantsLayer = true
//    collectionView.layer?.backgroundColor = NSColor.black.cgColor
  }
}

extension GridViewController: NSCollectionViewDataSource {
  // - NSCollectionViewDataSource
  func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
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
