//
//  SearchableBookListView.swift
//  ListsExample
//
//  Created by Peter Friese on 07.07.21.
//

import SwiftUI
import Combine

private extension String {
  func matches(_ searchTerm: String) -> Bool {
    self.range(of: searchTerm, options: .caseInsensitive) != nil
  }
}

class SearchableBooksViewModel: ObservableObject {
  // MARK: - Input
  // in a real application, we would fetch books from a repository or a service
  @Published private var originalBooks = Book.samples
  @Published var searchTerm: String = ""
  
  // MARK: - Output
  @Published var books = [Book]()
  
  init() {
    Publishers.CombineLatest($originalBooks, $searchTerm)
      .map { books, searchTerm in
        books.filter { book in
          searchTerm.isEmpty ? true : (book.title.matches(searchTerm) || book.author.matches(searchTerm))
        }
      }
      .assign(to: &$books)
  }
}

struct SearchableBooksListView: View {
  @StateObject var viewModel = SearchableBooksViewModel()
  var body: some View {
    List(viewModel.books) { book in
      SearchableBookRowView(book: book)
    }
    .searchable(text: $viewModel.searchTerm)
    .autocapitalization(.none) // to turn off autocapitalization on the search input field
  }
}

struct SearchableBookRowView: View {
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

struct SearchableBooksListViewDemo: View {
  var body: some View {
    VStack(alignment: .leading) {
      Introduction(Text("Use the `.searchable` view modifier to add a search bar to a `List` view"))
      SearchableBooksListView()
    }
    .listStyle(.insetGrouped) // to get back the original look and feel
    .navigationTitle("Searchable list")
  }
}

struct SearchableBooksListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SearchableBooksListViewDemo()
    }
  }
}

struct SearchableBookRowView_Previews: PreviewProvider {
  static var previews: some View {
    SearchableBookRowView(book: Book.samples[0])
      .previewLayout(.sizeThatFits)
  }
}
