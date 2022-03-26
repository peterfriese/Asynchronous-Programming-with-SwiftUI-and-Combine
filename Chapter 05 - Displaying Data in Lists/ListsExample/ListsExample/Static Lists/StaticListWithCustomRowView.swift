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
      CustomRowView("Apple", description: "Eat one a day", titleIcon: "🍏", count: 2)
      CustomRowView("Banana", description: "High in potassium", titleIcon: "🍌", count: 3)
      CustomRowView("Mango", description: "Soft and sweet", titleIcon: "🥭")
    }
  }
}

private struct CustomRowView: View {
  var title: String
  var description: String?
  var titleIcon: String
  var count: Int
  
  init(_ title: String, description: String? = nil, titleIcon: String, count: Int = 1) {
    self.title = title
    self.description = description
    self.titleIcon = titleIcon
    self.count = count
  }
  
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
        if let description = description {
          Text(description)
            .font(.subheadline)
        }
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

