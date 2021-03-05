//
//  BookShelfApp.swift
//  BookShelf
//
//  Created by Peter Friese on 09.01.21.
//

import SwiftUI

@main
struct BookShelfApp: App {
  var body: some Scene {
    WindowGroup {
      BooksListView(books: sampleBooks)
    }
  }
}
