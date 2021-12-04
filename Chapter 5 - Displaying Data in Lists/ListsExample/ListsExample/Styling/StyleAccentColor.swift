//
//  StyleAccentColor.swift
//  ListsExample
//
//  Created by Peter Friese on 25.09.21.
//

import SwiftUI

// MARK: - Demo infrastructure

struct StyleAccentColorDemo: View {
  var body: some View {
    VStack(alignment: .leading) {
      Introduction(Text("Use `.accentColor` to tint the color of the label images."))
      ListStylesBasicListView()
        .accentColor(Color.mint)
    }
    .navigationTitle("List Style: .sidebar")
  }
}

struct StyleAccentColor_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      StyleAccentColorDemo()
    }
  }
}
