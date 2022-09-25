//
//  InsetStyleListView.swift
//  ListsExample
//
//  Created by Peter Friese on 25.09.21.
//

import SwiftUI

// MARK: - Demo infrastructure

struct InsetStyleListViewDemo: View {
  var body: some View {
    VStack(alignment: .leading) {
      Introduction(Text("List that use the `.inset` style: have separators, are inset, and not grouped. "))
      ListStylesBasicListView()
        .listStyle(.inset)
    }
    .navigationTitle("List Style: .inset")
  }
}

struct InsetStyleListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      InsetStyleListViewDemo()
    }
  }
}

