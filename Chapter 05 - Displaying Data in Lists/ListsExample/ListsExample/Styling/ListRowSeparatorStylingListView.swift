//
//  ListRowSeparatorStylingListView.swift
//  ListsExample
//
//  Created by Peter Friese on 25.09.21.
//

import SwiftUI

struct ListRowSeparatorStylingListView: View {
  var body: some View {
    List {
      Text("Row 1")
      Text("Row 2 (separators hidden)")
        .listRowSeparator(.hidden)
      Text("Row 3")
      Text("Row 4 (separators tinted red)")
        .listRowSeparatorTint(.red)
      Text("Row 5")
      Text("Row 6 (bottom separator hidden)")
        .listRowSeparator(.hidden, edges: .bottom)
      Text("Row 7")
      Text("Row 8 (top separator tinted blue)")
        .listRowSeparatorTint(.blue, edges: .top)
      Text("Row 9")
      Text("Row 10")
    }
  }
}

// MARK: - Demo infrastructure

struct ListRowSeparatorStylingListViewDemo: View {
  var body: some View {
    VStack(alignment: .leading) {
      Introduction(Text("Use `.listRowSeparatorTint` and `.listRowSeparator` to style the row separators."))
      ListRowSeparatorStylingListView()
    }
    .navigationTitle("Styling Rows")
  }
}

struct ListRowSeparatorStylingListViewDemo_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ListRowSeparatorStylingListViewDemo()
    }
  }
}
