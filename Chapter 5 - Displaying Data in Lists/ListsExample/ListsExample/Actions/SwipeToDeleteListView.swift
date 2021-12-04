//
//  SwipeToDeleteListView.swift
//  ListsExample
//
//  Created by Peter Friese on 04.10.21.
//

import SwiftUI

private struct Item: Identifiable {
  var id = UUID().uuidString
  var title: String
  var iconName: String
  var badge: String
}

struct SwipeToDeleteListView: View {
  @State fileprivate var items = [
    Item(title: "Puzzle", iconName: "puzzlepiece", badge: "Nice!"),
    Item(title: "Controller", iconName: "gamecontroller", badge: "Clicky!"),
    Item(title: "Shopping cart", iconName: "cart", badge: "$$$"),
    Item(title: "Gift", iconName: "giftcard", badge: ":-)"),
    Item(title: "Clock", iconName: "clock", badge: "Tick tock"),
    Item(title: "People", iconName: "person.2", badge: "2"),
    Item(title: "T-Shirt", iconName: "tshirt", badge: "M")
  ]

  var body: some View {
    List {
      ForEach(items) { item in
        Label(item.title, systemImage: item.iconName)
      }
      .onDelete { indexSet in
        items.remove(atOffsets: indexSet)
      }
      .onMove { indexSet, index in
        items.move(fromOffsets: indexSet, toOffset: index)
      }
    }
//    .environment(\.editMode, .constant(.active))
    .toolbar {
      EditButton()
    }
  }
}

// MARK: - Demo infrastructure

struct SwipeToDeleteListViewDemo: View {
  var body: some View {
    VStack(alignment: .leading) {
      Introduction(Text(
        """
        To implement _swipe to delete_, add the `onDelete` view modifier to a `ForEeach` view.
        In addtion, you can use `EditButton` to let users toggle edit mode.
        This allows them to delete or reorder items.
        """))
      SwipeToDeleteListView()
        .listStyle(.plain)
    }
    .navigationTitle("Delete / move items")
  }
}

struct SwipeToDeleteListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SwipeToDeleteListViewDemo()
    }
  }
}


