//
//  ContentView.swift
//  BookShelf
//
//  Created by Peter Friese on 02/01/2021.
//

import SwiftUI

struct BooksListView: View {
  @ObservedObject var booksViewModel: BooksViewModel
  
  var body: some View {
    List {
      ForEach($booksViewModel.books) { $book in
        BookRowView(book: $book)
      }
      .onDelete { indexSet in
        booksViewModel.books.remove(atOffsets: indexSet)
      }
    }
    .navigationTitle("Books")
  }
}

struct BooksListView_Previews: PreviewProvider {
  static let booksViewModel = BooksViewModel()
  
  static var previews: some View {
    NavigationStack {
      BooksListView(booksViewModel: booksViewModel)
    }
  }
}
