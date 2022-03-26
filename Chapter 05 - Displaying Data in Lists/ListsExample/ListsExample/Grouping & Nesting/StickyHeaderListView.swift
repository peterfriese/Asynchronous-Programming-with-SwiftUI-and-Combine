//
//  StickyHeaderListView.swift
//  ListsExample
//
//  Created by Peter Friese on 25.09.21.
//

import SwiftUI

struct StickyHeaderListView: View {
  var fruits = [
    "Apples", "Bananas", "Mangoes",
    "Strawberries", "Watermelon", "Grapes",
    "Oranges", "Pineapples", "Peaches", "Raspberries"
  ]
  var vegetables = [
    "Carrots", "Potato", "Tomato",
    "Onions", "Broccoli", "Mushroom",
    "Lettuce", "Capsicum", "Pumpkin", "Zucchini"
  ]
  var legumes = [
    "Chickpeas", "Lentils", "Peas",
    "Kidney Beans", "Black Beans", "Soybeans",
    "Pinto Beans", "Navy Beans"
  ]
  
  var body: some View {
    List {
      Section("Fruits") {
        ForEach(fruits, id: \.self) { fruit in
          Text(fruit)
        }
      }
      Section("Vegetables") {
        ForEach(vegetables, id: \.self) { vegetable in
          Text(vegetable)
        }
      }
      Section("Legumes") {
        ForEach(legumes, id: \.self) { legume in
          Text(legume)
        }
      }

    }
    .listStyle(.plain)
  }
}

// MARK: - Demo infrastructure

struct StickyHeaderListViewDemo: View {
  var body: some View {
    VStack(alignment: .leading) {
      Introduction("Plain lists have sticky headers. Scroll down to see this in action")
      StickyHeaderListView()
    }
    .listStyle(.insetGrouped) // to get back the original look and feel
    .navigationTitle("Sticky Header")
  }
}

struct StickyHeaderListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      StaticListView2Demo()
    }
  }
}
