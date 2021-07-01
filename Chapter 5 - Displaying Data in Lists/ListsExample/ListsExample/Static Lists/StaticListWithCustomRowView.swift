//
//  StaticListCustomRow.swift
//  ListsExample
//
//  Created by Peter Friese on 30.06.21.
//

import SwiftUI

struct StaticListWithCustomRowView: View {
  var body: some View {
    List {
      CustomRowView(titleIcon: "🍏", title: "Apple", description: "Eat one a day", count: 2)
      CustomRowView(titleIcon: "🍌", title: "Banana", description: "High in potassium", count: 3)
      CustomRowView(titleIcon: "🥭", title: "Mango", description: "Soft and sweet", count: 1)
    }
  }
}

struct CustomRowView: View {
  var titleIcon: String
  var title: String
  var description: String
  var count: Int
  
  var body: some View {
    HStack {
      Text(titleIcon)
        .font(.title)
        .padding(4)
        .background(Color(UIColor.tertiarySystemFill))
        .cornerRadius(10)
      VStack(alignment: .leading) {
        Text(title)
          .font(.headline)
        Text(description)
          .font(.subheadline)
      }
      Spacer()
      Text("\(count)")
        .font(.title)
    }
  }
}

// MARK: - Demo infrastructure

struct StaticListWithCustomRowViewDemo: View {
  var body: some View {
    VStack(alignment: .leading) {
      Introduction(Text("To make custom rows reusable, extract them into a separate view. In this example, the rows are displayed by `CustomRowView`."))
      StaticListWithCustomRowView()
    }
    .listStyle(.insetGrouped) // to get back the original look and feel
    .navigationTitle("List with extracted row")
  }
}

struct StaticListWithCustomRowViewDemo_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      NavigationView {
        StaticListWithCustomRowViewDemo()
          .navigationTitle("List w/ Custom Row")
      }
      .previewLayout(.device)
      NavigationView {
        StaticListWithCustomRowViewDemo()
          .navigationTitle("List w/ Custom Row")
      }
      .preferredColorScheme(.dark)
    }
  }
}

