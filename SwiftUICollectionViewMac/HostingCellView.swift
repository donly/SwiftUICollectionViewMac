//
//  HostingCellView.swift
//  SwiftUICollectionViewMac
//
//  Created by Don on 30/10/2020.
//

import Cocoa
import SwiftUI

class HostingCellView: NSCollectionViewItem {

  override func loadView() {
    print("loadView")
    super.loadView()
  }
  
  override func viewDidLoad() {
    print("viewDidLoad")
    super.viewDidLoad()
    // Do view setup here.
    view.wantsLayer = true
    view.layer?.backgroundColor = NSColor.blue.cgColor
  }
  
  func setView<Content>(_ newValue: Content) where Content: View {
    for view in self.view.subviews {
      view.removeFromSuperview()
    }

    let hostView = NSHostingView(rootView: newValue)
//    view.translatesAutoresizingMaskIntoConstraints = true
//    view.autoresizingMask = [.width, .height]
    self.view.addSubview(hostView)
    hostView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      hostView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
      hostView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
      hostView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
      hostView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
    ])
    hostView.layer?.masksToBounds = true
    
  }
    
}
