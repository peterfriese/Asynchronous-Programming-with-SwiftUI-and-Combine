//
//  SwipeActionsListView.swift
//  ListsExample
//
//  Created by Peter Friese on 04.10.21.
//

import SwiftUI

private struct Item: Identifiable, Equatable {
  var id = UUID().uuidString
  var title: String
  var iconName: String
  var badge: String
  var isRead: Bool = false
}

class ViewModel: ObservableObject {
  @Published fileprivate var items = [
    Item(title: "Puzzle", iconName: "puzzlepiece", badge: "Nice!", isRead: true),
    Item(title: "Controller", iconName: "gamecontroller", badge: "Clicky!"),
    Item(title: "Shopping cart", iconName: "cart", badge: "$$$"),
    Item(title: "By default, the icon of a swipe action will be visible. The text label will be visible if the row's height exceeds a certain threshold.", iconName: "arrow.up.and.down", badge: "3 lines"),
    Item(title: "Gift", iconName: "giftcard", badge: ":-)"),
    Item(title: "Clock", iconName: "clock", badge: "Tick tock"),
    Item(title: "People", iconName: "person.2", badge: "2"),
    Item(title: "T-Shirt", iconName: "tshirt", badge: "M")
  ]
  
  fileprivate func deleteItem(_ item: Item) {
    if let index = items.firstIndex(where: { $0.id == item.id }) {
      items.remove(at: index)
    }
  }
  
  fileprivate func markItemRead(_ item: Item) {
    if let index = items.firstIndex(where: { $0.id == item.id }) {
      items[index].isRead.toggle()
    }
  }

}

struct SwipeActionsListView: View {
  @StateObject var viewModel = ViewModel()
  @State fileprivate var selectedItem: Item? = nil
  
  var body: some View {
    List(viewModel.items) { item in
      Text(item.title)
        .fontWeight(item.isRead ? .regular : .bold)
        .badge(item.badge)
        .swipeActions(edge: .leading) {
          Button (action: { viewModel.markItemRead(item) }) {
            if let isRead = item.isRead, isRead == true {
              Label("Read", systemImage: "envelope.badge.fill")
            }
            else {
              Label("Unread", systemImage: "envelope.open.fill")
            }
          }
          .tint(.blue)
        }
        .swipeActions(edge: .trailing) {
          Button(role: .destructive, action: { viewModel.deleteItem(item) } ) {
            Label("Delete", systemImage: "trash")
          }
        }
        .swipeActions(edge: .trailing) {
          Button (action: { selectedItem = item  } ) {
            Label("Tag", systemImage: "tag")
          }
          .tint(Color(UIColor.systemOrange))
        }
    }
    .sheet(item: $selectedItem) { item in
      NavigationView {
        TagsView(item: item)
      }
    }
    .animation(.default, value: viewModel.items)
  }
}

struct TagsView: View {
  fileprivate var item: Item
  var body: some View {
    VStack(alignment: .leading) {
      Introduction(Text("Use this screen to assign one or more tags to the selected item. (This isn't implemented yet.)"))
      List {
        Label("Thing", systemImage: "tag")
        Label("Place", systemImage: "tag")
      }
      .listStyle(.insetGrouped)
    }
    .navigationBarTitle("Tags for \(item.title)")
  }
}

// MARK: - Demo infrastructure

struct SwipeActionsListViewDemo: View {
  var body: some View {
    VStack(alignment: .leading) {
      Introduction(Text("Swipe Actions"))
      SwipeActionsListView()
        .listStyle(.plain)
    }
    .navigationTitle("Swipe Actions")
  }
}

struct SwipeActionsListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SwipeActionsListViewDemo()
    }
  }
}

