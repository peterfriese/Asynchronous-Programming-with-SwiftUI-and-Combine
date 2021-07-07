//
//  MenuScreen.swift
//  ListsExample
//
//  Created by Peter Friese on 01.07.21.
//

import SwiftUI

struct MenuScreen: View {
  var body: some View {
    NavigationView {
      List() {
        Section(header: Text("Static Lists")) {
          NavigationLink(destination: StaticListViewDemo()) {
            Label("Static list with simple row", systemImage: "1.square")
          }
          NavigationLink(destination: StaticListView2Demo()) {
            Label("Static list with multiple simple rows", systemImage: "2.square")
          }
          NavigationLink(destination: StaticListWithSimpleCustomRowViewDemo()) {
            Label("Static list with custom row", systemImage: "3.square")
          }
          NavigationLink(destination: StaticListWithCustomRowViewDemo()) {
            Label("Static list with extracted row", systemImage: "4.square")
          }
        }
        Section(header: Text("Dynamic Lists")) {
          NavigationLink(destination: BooksListViewDemo()) {
            Label("Books List View", systemImage: "5.square")
          }
          NavigationLink(destination: SearchableBooksListViewDemo()) {
            Label("Searchable Books List View", systemImage: "6.square")
          }
          Label("Dummy", systemImage: "7.square")
          Label("Dummy", systemImage: "8.square")
          Label("Dummy", systemImage: "9.square")
        }
      }
      .listStyle(InsetGroupedListStyle())
      .navigationTitle("SwiftUI Lists")
    }
  }
}

struct MenuScreen_Previews: PreviewProvider {
  static var previews: some View {
    MenuScreen()
  }
}
