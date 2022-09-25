//
//  ListSectionSeparatorStylingListView.swift
//  ListsExample
//
//  Created by Peter Friese on 25.09.21.
//

import SwiftUI

struct ListSectionSeparatorStylingListView: View {
  var body: some View {
    List {
      Section(header: Text("Section 1"), footer: Text("Section 1 - no styling")) {
        Text("Row 1")
        Text("Row 2")
        Text("Row 3")
        Text("Row 4")
        Text("Row 5")
      }
      
      Section(header: Text("Section 2"), footer: Text("Section 2 - section separators hidden")) {
        Text("Row 1")
        Text("Row 2")
        Text("Row 3")
        Text("Row 4")
        Text("Row 5")
      }
      .listSectionSeparator(.hidden)
      
      Section(header: Text("Section 3"), footer: Text("Section 3 - section separator tinted red")) {
        Text("Row 1")
        Text("Row 2")
        Text("Row 3")
        Text("Row 4")
        Text("Row 5")
      }
      .listSectionSeparatorTint(.red)
      
      Section(header: Text("Section 4"), footer: Text("Section 4 - section separators tinted green")) {
        Text("Row 1")
        Text("Row 2")
        Text("Row 3")
        Text("Row 4")
        Text("Row 5")
      }
      .listSectionSeparatorTint(.green, edges: [.top, .bottom]) // Note: "The list style might decide to not display certain separators," (Apple docs)
      
      Section(header: Text("Section 5"), footer: Text("Section 5 - section separator (bottom) hidden")) {
        Text("Row 1")
        Text("Row 2")
        Text("Row 3")
        Text("Row 4")
        Text("Row 5")
      }
      .listSectionSeparator(.hidden, edges: .bottom)
      
      Section("Section 6") {
        Text("Row 1")
        Text("Row 2")
        Text("Row 3")
        Text("Row 4")
        Text("Row 5")
      }
      Section("Section 7") {
        Text("Row 1")
        Text("Row 2")
        Text("Row 3")
        Text("Row 4")
        Text("Row 5")
      }

      
    }
  }
}

// MARK: - Demo infrastructure

struct ListSectionSeparatorStylingListViewDemo: View {
  var body: some View {
    VStack(alignment: .leading) {
      Introduction(Text("Use `.listSectionSeparator` and `.listSectionSeparatorTint` to style the section separators."))
      ListSectionSeparatorStylingListView()
        .listStyle(.plain)
    }
    .navigationTitle("Styling Section")
  }
}

struct ListSectionSeparatorStylingListViewDemo_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      ListSectionSeparatorStylingListViewDemo()
    }
  }
}

