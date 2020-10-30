//
//  ContentView.swift
//  SwiftUICollectionViewMac
//
//  Created by Don on 27/10/2020.
//

import SwiftUI

struct ContentView: View {
  let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  var body: some View {
    VStack {
      GeometryReader { proxy in
        GridView(proxy: proxy, numbers: numbers)
          .frame(width: proxy.size.width, height: proxy.size.height)
        .background(Color.gray)
      }
    }
//    GridView()
  }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
