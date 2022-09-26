//
//  PlainStyleListView.swift
//  ListsExample
//
//  Created by Peter Friese on 25.09.21.
//

import SwiftUI

// MARK: - Demo infrastructure

struct PlainStyleListViewDemo: View {
  var body: some View {
    VStack(alignment: .leading) {
      Introduction(Text("List that use the `.plain` style: have separators, no inset, and will not be grouped."))
      ListStylesBasicListView()
        .listStyle(.plain)
    }
    .navigationTitle("List Style: .plain")
  }
}

struct PlainStyleListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      PlainStyleListViewDemo()
    }
  }
}


