//
//  AsyncFetchAsyncFetchBooksListView.swift
//  AsyncFetchAsyncFetchBooksListView
//
//  Created by Peter Friese on 26.08.21.
//

import SwiftUI

private class AsyncFetchBooksViewModel: ObservableObject {
  @Published var books = [Book]()
  @Published var fetching = false
  
  @MainActor
  func fetchData() async {
    fetching = true
    await Task.sleep(2_000_000_000)
    books = Book.samples
    fetching = false
  }
}

struct AsyncFetchBooksListView: View {
  @StateObject fileprivate var viewModel = AsyncFetchBooksViewModel()
  
  var body: some View {
    List(viewModel.books) { book in
      AsyncFetchBookRowView(book: book)
    }
    .overlay {
      if viewModel.fetching {
        ProgressView("Fetching data, please wait...")
          .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
      }
    }
    // By default, list views aren't animated. Adding this line animates the list view whenever the collection of books has changed.
    .animation(.default, value: viewModel.books)
    .task {
      await viewModel.fetchData()
    }
  }
}

private struct AsyncFetchBookRowView: View {
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

struct AsyncFetchBooksListViewDemo: View {
  var body: some View {
    VStack(alignment: .leading) {
      Introduction(Text("Use the `task` view modifier to fetch data asynchronously."))
      AsyncFetchBooksListView()
    }
    .listStyle(.insetGrouped) // to get back the original look and feel
    .navigationTitle("Dynamic list")
  }
}

struct AsyncFetchBooksListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      AsyncFetchBooksListViewDemo()
    }
  }
}
