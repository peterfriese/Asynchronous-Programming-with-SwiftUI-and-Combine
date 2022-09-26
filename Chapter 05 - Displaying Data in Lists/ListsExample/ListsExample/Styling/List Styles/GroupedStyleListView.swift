//
//  GroupedStyleListView.swift
//  ListsExample
//
//  Created by Peter Friese on 25.09.21.
//

import SwiftUI

// MARK: - Demo infrastructure

struct GroupedStyleListViewDemo: View {
  var body: some View {
    VStack(alignment: .leading) {
      Introduction(Text("List that use the `.grouped` style: have separators, no inset, and are displayed grouped."))
      ListStylesBasicListView()
        .listStyle(.grouped)
    }
    .navigationTitle("List Style: .grouped")
  }
}

struct GroupedStyleListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      GroupedStyleListViewDemo()
    }
  }
}

