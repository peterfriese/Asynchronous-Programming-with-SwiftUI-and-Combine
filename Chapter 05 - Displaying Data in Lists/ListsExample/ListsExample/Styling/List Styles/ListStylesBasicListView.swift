//
//  ListStylesBasicListView.swift
//  ListsExample
//
//  Created by Peter Friese on 25.09.21.
//

import SwiftUI

struct ListStylesBasicListView: View {
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
      // new way of setting up headers and footers
      Section {
        ForEach(fruits, id: \.self) { fruit in
          Label(fruit, systemImage: "\(fruits.firstIndex(of: fruit) ?? 0).circle.fill" )
        }
      } header: {
        Text("Fruits")
      } footer: {
        Text("\(fruits.count) fruits")
      }
      // old way of setting up headers and footers, this is marked for deprecation
      Section(header: Text("Vegetables"), footer: Text("\(vegetables.count) vegetables")) {
        ForEach(vegetables, id: \.self) { vegetable in
          Label(vegetable, systemImage: "\(vegetables.firstIndex(of: vegetable) ?? 0).circle.fill" )
        }
      }
      Section(header: Text("Legumes"), footer: Text("\(legumes.count) legumes")) {
        ForEach(legumes, id: \.self) { legume in
          Label(legume, systemImage: "\(legumes.firstIndex(of: legume) ?? 0).circle.fill" )
        }
      }
    }
  }
}
