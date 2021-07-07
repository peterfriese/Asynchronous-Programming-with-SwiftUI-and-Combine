//
//  RefreshableBookListView.swift
//  ListsExample
//
//  Created by Peter Friese on 07.07.21.
//

import SwiftUI
import LoremSwiftum

class RefreshableBooksViewModel: ObservableObject {
  @Published var books: [Book] = Book.samples
  
  private func generateNewBook() -> Book {
    let title = Lorem.sentence
    let author = Lorem.fullName
    let pageCount = Int.random(in: 42...999)
    return Book(title: title, author: author, isbn: "9781234567890", pages: pageCount)
  }
  
  func refresh() async {
    // in Xcode 13 b1 and b2, this crashes. Add SWIFT_DEBUG_CONCURRENCY_ENABLE_COOPERATIVE_QUEUES = NO to the target's environment values as a workaround
    await Task.sleep(2_000_000_000)
    let book = generateNewBook()
    books.insert(book, at: 0)
  }
}

struct RefreshableBooksListView: View {
  @StateObject var viewModel = RefreshableBooksViewModel()
  var body: some View {
    List(viewModel.books) { book in
      RefreshableBookRowView(book: book)
    }
    .refreshable {
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
    NavigationView {
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
