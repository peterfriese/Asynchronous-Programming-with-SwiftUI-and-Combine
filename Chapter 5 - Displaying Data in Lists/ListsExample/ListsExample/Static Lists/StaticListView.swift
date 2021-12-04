//
//  ContentView.swift
//  ListsExample
//
//  Created by Peter Friese on 30.06.21.
//

import SwiftUI

struct StaticListView: View {
  var body: some View {
    List {
      Text("Hello, world!")
      Text("Hello, SwiftUI!")
    }
  }
}

// MARK: - Demo infrastructure

struct StaticListViewDemo: View {
  var body: some View {
    VStack(alignment: .leading) {
      Introduction("You can place other views inside a List.")
      StaticListView()
    }
    .listStyle(.insetGrouped) // to get back the original look and feel
    .navigationTitle("List with simple row")
  }
}

struct StaticListViewDemo_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      StaticListViewDemo()
    }
  }
}
