//
//  BasicListForStyling.swift
//  BasicListForStyling
//
//  Created by Peter Friese on 14.08.21.
//

import SwiftUI

private struct Item {
  var title: String
  var iconName: String
  var badge: String
}

struct BasicListForStyling: View {
  @State fileprivate var items = [
    Item(title: "Puzzle", iconName: "puzzlepiece", badge: "Nice!"),
    Item(title: "Controller", iconName: "gamecontroller", badge: "Clicky!"),
    Item(title: "Shopping cart", iconName: "cart", badge: "$$$"),
    Item(title: "Gift", iconName: "giftcard", badge: ":-)"),
    Item(title: "Clock", iconName: "clock", badge: "Tick tock"),
    Item(title: "People", iconName: "person.2", badge: "2"),
    Item(title: "T-Shirt", iconName: "tshirt", badge: "M")
  ]
  
  @Binding var showSeparators: Bool
  @Binding var foregroundColor: Color
  @Binding var listItemTintColor: Color
  @Binding var separatorTintColor: Color
  @Binding var rowBackgroundColor: Color

  
  var body: some View {
    List(items, id: \.title) { item in
      Label(item.title, systemImage: item.iconName)
        .badge(item.badge)
      // listItemTint and foregroundColor are mutually exclusive
//        .listItemTint(listItemTintColor)
        .foregroundColor(foregroundColor)
        .listRowSeparator(showSeparators == true ? .visible : .hidden)
        .listRowSeparatorTint(separatorTintColor)
        .listRowBackground(rowBackgroundColor)
    }
  }
}

// MARK: - Demo infrastructure

struct BasicListForStylingDemo: View {
  @State var showSeparators = true
  @State var showBadges = true
  @State var foregroundColor: Color = Color(UIColor.systemPink)
  @State var listItemTintColor: Color = Color(UIColor.systemPink)
  @State var separatorTintColor: Color = Color(UIColor.systemPink)
  @State var rowBackgroundColor: Color = Color(UIColor.systemMint)
  
  var body: some View {
    VStack(alignment: .leading) {
      Introduction("Style your lists")
      VStack {
        Toggle("Show separators", isOn: $showSeparators)
        ColorPicker("Foreground color", selection: $foregroundColor)
        ColorPicker("List item tint color", selection: $listItemTintColor)
        ColorPicker("Separator tint color", selection: $separatorTintColor)
        ColorPicker("Row background color", selection: $rowBackgroundColor)
      }
      .padding()
      BasicListForStyling(showSeparators: $showSeparators,
                          foregroundColor: $foregroundColor,
                          listItemTintColor: $listItemTintColor,
                          separatorTintColor: $separatorTintColor,
                          rowBackgroundColor: $rowBackgroundColor)
    }
    .listStyle(.sidebar) // to get back the original look and feel
    .navigationTitle("Styling")
  }
}

struct BasicListForStylingDemo_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      BasicListForStylingDemo()
    }
  }
}
