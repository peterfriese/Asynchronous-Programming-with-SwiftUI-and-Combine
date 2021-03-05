//
//  BookShelfApp.swift
//  BookShelf
//
//  Created by Peter Friese on 02/01/2021.
//

import SwiftUI

@main
struct BookShelfApp: App {
  var body: some Scene {
    WindowGroup {
      NavigationView {
        BooksListView()
          .navigationTitle("Books")
      }
    }
  }
}
