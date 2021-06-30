//
//  ContentView.swift
//  BookShelf
//
//  Created by Peter Friese on 02/01/2021.
//

import SwiftUI

struct BooksListView: View {
  var books: [Book]
  var body: some View {
    List {
      ForEach(books) { book in
        BookRowView(book: book)
      }
      .listRowBackground(Color(UIColor.systemGray6))
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      BooksListView(books: sampleBooks)
        .preferredColorScheme(.dark)
      BooksListView(books: sampleBooks)
        .preferredColorScheme(.light)
    }
  }
}
