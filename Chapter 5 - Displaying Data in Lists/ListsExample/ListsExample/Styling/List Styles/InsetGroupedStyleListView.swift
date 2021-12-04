//
//  InsetGroupedListView.swift
//  ListsExample
//
//  Created by Peter Friese on 25.09.21.
//

import SwiftUI

// MARK: - Demo infrastructure

struct InsetGroupedStyleListViewDemo: View {
  var body: some View {
    VStack(alignment: .leading) {
      Introduction(Text("List that use the `.insetGrouped` style: have separators, are inset, and are displated grouped."))
      ListStylesBasicListView()
        .listStyle(.insetGrouped)
    }
    .navigationTitle("List Style: .insetGrouped")
  }
}

struct InsetGroupedStyleListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      InsetGroupedStyleListViewDemo()
    }
  }
}

