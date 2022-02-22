//
//  ContentView.swift
//  BookShelf
//
//  Created by Peter Friese on 09.01.21.
//

import SwiftUI

struct BooksListView: View {
  var books: [Book]
  var body: some View {
    List(books) { book in
      BookRowView(book: book)
    }
    .listStyle(.plain)
  }
}

struct BooksListView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      BooksListView(books: sampleBooks)
      BooksListView(books: sampleBooks)
        .preferredColorScheme(.dark)
    }
  }
}
