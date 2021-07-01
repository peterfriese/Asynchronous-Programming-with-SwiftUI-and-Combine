//
//  StaticListSimpleCustomRow.swift
//  ListsExample
//
//  Created by Peter Friese on 30.06.21.
//

import SwiftUI

struct StaticListWithSimpleCustomRowView: View {
  var body: some View {
    List {
      VStack(alignment: .leading) {
        Text("Apples")
          .font(.headline)
        Text("Eat one a day")
          .font(.subheadline)
      }
      VStack(alignment: .leading) {
        Text("Bananas")
          .font(.headline)
        Text("High in potassium")
          .font(.subheadline)
      }
    }
  }
}

// MARK: - Demo infrastructure

struct StaticListWithSimpleCustomRowViewDemo: View {
  var body: some View {
    VStack(alignment: .leading) {
      Introduction("You can create custom list rows by grouping a bunch of views using VStack and HStack.")
      StaticListWithSimpleCustomRowView()
    }
    .listStyle(.insetGrouped) // to get back the original look and feel
    .navigationTitle("List with custom row")
  }
}

struct StaticListWithSimpleCustomRowViewDemo_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      StaticListWithSimpleCustomRowViewDemo()
    }
  }
}
