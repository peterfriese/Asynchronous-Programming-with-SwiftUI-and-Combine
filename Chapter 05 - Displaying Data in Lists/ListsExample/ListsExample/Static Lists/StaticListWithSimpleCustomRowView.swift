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
      CustomRowView(title: "Apples", subtitle: "Eat one a day")
      CustomRowView(title: "Bananas", subtitle: "High in potassium")
    }
  }
}

private struct CustomRowView: View {
  var title: String
  var subtitle: String
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(title)
        .font(.headline)
      Text(subtitle)
        .font(.subheadline)
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
    Group {
      NavigationView {
        StaticListWithSimpleCustomRowViewDemo()
      }
    }
  }
}
