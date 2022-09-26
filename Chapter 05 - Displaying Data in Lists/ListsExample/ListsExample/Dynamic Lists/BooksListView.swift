//
//  BooksListView.swift
//  ListsExample
//
//  Created by Peter Friese on 01.07.21.
//

import SwiftUI

private class BooksViewModel: ObservableObject {
  @Published var books: [Book] = Book.samples
}

struct BooksListView: View {
  @StateObject fileprivate var viewModel = BooksViewModel()
  var body: some View {
    List(viewModel.books) { book in
      BookRowView(book: book)
    }
  }
}

private struct BookRowView: View {
  var book: Book
  
  var body: some View {
    HStack(alignment: .top) {
      Image(book.mediumCoverImageName)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(height: 90)
      VStack(alignment: .leading) {
        Text(book.title)
          .font(.headline)
        Text("by \(book.author)")
          .font(.subheadline)
        Text("\(book.pages) pages")
          .font(.subheadline)
      }
      Spacer()
    }
  }
}

// MARK: - Demo infrastructure

struct BooksListViewDemo: View {
  var body: some View {
    VStack(alignment: .leading) {
      Introduction("You can display dynamic data in a list by iterating over a collection")
      BooksListView()
    }
    .listStyle(.insetGrouped) // to get back the original look and feel
    .navigationTitle("Dynamic list")
  }
}

struct BooksListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      BooksListViewDemo()
    }
  }
}

struct BookRowView_Previews: PreviewProvider {
  static var previews: some View {
    BookRowView(book: Book.samples[0])
      .previewLayout(.sizeThatFits)
  }
}
