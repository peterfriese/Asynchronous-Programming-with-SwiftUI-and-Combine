//
//  BooksListViewWithCombine.swift
//  WrappingExistingAPIsInCombine
//
//  Created by Peter Friese on 12.04.22.
//

import SwiftUI
import Combine
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseFirestoreCombineSwift

private class BookListViewModel: ObservableObject {
  @Published var books = [Book]()
  @Published var errorMessage: String?
  
  private var db = Firestore.firestore()
  private var cancellable: AnyCancellable?
  
  func subscribe() {
    cancellable = db.collection("books").snapshotPublisher()
      .tryMap { querySnapshot in
        try querySnapshot.documents.compactMap { documentSnapshot in
          try documentSnapshot.data(as: Book.self)
        }
      }
      .replaceError(with: [Book]())
      .handleEvents(receiveCancel: {
        print("Cancelled")
      })
      .assign(to: \.books, on: self)
  }
  
  func unsubscribe() {
    cancellable?.cancel()
  }
}

struct LiveBooksListViewWithCombine: View {
  @StateObject private var viewModel = BookListViewModel()
  
  var body: some View {
    SampleScreen("Fetch live collection with Combine", introduction: "This screen fetches all books from the 'books' collection using a snapshot listener and Combine.") {
      List(viewModel.books) { book in
        Text(book.title)
      }
      .onAppear {
        viewModel.subscribe()
      }
      .onDisappear {
        viewModel.unsubscribe()
      }
    }
  }
}

struct LiveBooksListViewWithCombine_Previews: PreviewProvider {
  static var previews: some View {
    LiveBooksListViewWithCombine()
  }
}

