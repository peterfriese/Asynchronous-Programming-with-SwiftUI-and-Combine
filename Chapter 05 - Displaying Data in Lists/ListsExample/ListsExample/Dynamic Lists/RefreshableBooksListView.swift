//
//  RefreshableBookListView.swift
//  ListsExample
//
//  Created by Peter Friese on 07.07.21.
//

import SwiftUI
import LoremSwiftum

@MainActor
class RefreshableBooksViewModel: ObservableObject {
  @Published var books: [Book] = Book.samples
  
  private func generateNewBook() -> Book {
    let title = Lorem.sentence
    let author = Lorem.fullName
    let pageCount = Int.random(in: 42...999)
    return Book(title: title, author: author, isbn: "9781234567890", pages: pageCount)
  }
  
  func refresh() async {
    do {
      try await Task.sleep(nanoseconds: 2_000_000_000)
    }
    catch {
    }
    let book = generateNewBook()
    books.insert(book, at: 0)
    
    // the following line, in combination with the `.animation` modifier, makes sure we have a smooth animation
    do {
      try await Task.sleep(nanoseconds: 500_000_000)
    }
    catch {
    }
  }
}

struct RefreshableBooksListView: View {
  @StateObject var viewModel = RefreshableBooksViewModel()
  var body: some View {
    List(viewModel.books) { book in
      RefreshableBookRowView(book: book)
    }
    // By default, list views aren't animated. Adding this line animates the list view whenever the collection of books has changed.
    .animation(.default, value: viewModel.books)
    .refreshable {
      // As `.refreshable` is an asynchonous method, we need to make sure to execute updates on the main thread.
      // Thanks to Swift's new concurrency model, this is now a lot simpler than it used to be. In the past, we would've had to
      // use `DispatchQueue.main.async { }` to execute async code and then jump on the main queue to perform the update. Now, it
      // is suffiecient to just mark the `ObservableObject` as `@MainActor` to ensure all upates are executed on the main actor.
      // If you forget to do this, Xcode will display a purple runtime warning saying "Publishing changes from background
      // threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates."
      await viewModel.refresh()
    }
  }
}

struct RefreshableBookRowView: View {
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

struct RefreshableBooksListViewDemo: View {
  var body: some View {
    VStack(alignment: .leading) {
      Introduction(Text("This list uses the `.refreshable` view modifier to implement pull-to-refresh. Go ahead and give it a try: pull down on the list to fetch new data."))
      RefreshableBooksListView()
    }
    .listStyle(.insetGrouped) // to get back the original look and feel
    .navigationTitle("Refreshable list")
  }
}

struct RefreshableBooksListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      RefreshableBooksListViewDemo()
    }
  }
}

struct RefreshableBookRowView_Previews: PreviewProvider {
  static var previews: some View {
    RefreshableBookRowView(book: Book.samples[0])
      .previewLayout(.sizeThatFits)
  }
}
