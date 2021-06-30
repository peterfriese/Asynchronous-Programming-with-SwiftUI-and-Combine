//
//  BookShelfApp.swift
//  BookShelf
//
//  Created by Peter Friese on 02/01/2021.
//

import SwiftUI

@main
struct BookShelfApp: App {
  // By pulling up the source of truth to the app, we make sure that all the app's
  // windows share the same source of truth. In case each BooksListView had their own
  // @StateObject var booksViewModel = BooksViewModel(), any changes made to any of
  // them wouldn't be reflected on the other ones.
  // See this in action by running the app on an iPad and then use multi-tasking to arrange
  // two app windows side-by-side.
  @StateObject var booksViewModel = BooksViewModel()
  
  var body: some Scene {
    WindowGroup {
      NavigationView {
        BooksListView(booksViewModel: booksViewModel)
          .navigationTitle("Books")
      }
    }
  }
}
