//
//  AutomaticStyleListView.swift
//  ListsExample
//
//  Created by Peter Friese on 25.09.21.
//

import SwiftUI

// MARK: - Demo infrastructure

struct AutomaticStyleListViewDemo: View {
  var body: some View {
    VStack(alignment: .leading) {
      Introduction(Text("List that use the `.automatic` style: have separators, are inset, and will be displayed grouped"))
      ListStylesBasicListView()
        .listStyle(.automatic)
    }
    .navigationTitle("List Style: .automatic")
  }
}

struct AutomaticStyleListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      AutomaticStyleListViewDemo()
    }
  }
}

