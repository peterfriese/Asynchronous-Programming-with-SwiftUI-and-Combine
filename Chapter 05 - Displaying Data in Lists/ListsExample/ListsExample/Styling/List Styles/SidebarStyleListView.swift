//
//  SidebarStyleListView.swift
//  ListsExample
//
//  Created by Peter Friese on 25.09.21.
//

import SwiftUI

// MARK: - Demo infrastructure

struct SidebarStyleListViewDemo: View {
  var body: some View {
    VStack(alignment: .leading) {
      Introduction(Text("List that use the `.sidebar` style: have no separators, no inset and aren't grouped. They can be expanded. "))
      ListStylesBasicListView()
        .listStyle(.sidebar)
    }
    .navigationTitle("List Style: .sidebar")
  }
}

struct SidebarStyleListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      SidebarStyleListViewDemo()
    }
  }
}
