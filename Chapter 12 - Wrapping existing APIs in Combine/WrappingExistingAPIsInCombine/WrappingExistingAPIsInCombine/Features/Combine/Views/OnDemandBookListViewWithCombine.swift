//
//  OnDemandBookListViewWithCombine.swift
//  WrappingExistingAPIsInCombine
//
//  Created by Peter Friese on 12.04.22.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

private class BookListViewModel: ObservableObject {
  @Published var books = [Book]()
  @Published var errorMessage: String?
  
  private var db = Firestore.firestore()
  
  fileprivate func fetchBooks() {
    db.collection("books").getDocuments()
      .tryMap { querySnapshot in
        try querySnapshot.documents.compactMap { documentSnapshot in
          try documentSnapshot.data(as: Book.self)
        }
      }
      .replaceError(with: [Book]())
      .assign(to: &$books)
  }
}

struct OnDemandBookListViewWithCombine: View {
  @StateObject private var viewModel = BookListViewModel()
  
  var body: some View {
    SampleScreen("Fetch collection once",
                 introduction: "This screen fetches all books from the 'books' collection once. \n\n"
                 + "You can also pull down to refresh.") {
      List(viewModel.books) { book in
        Text(book.title)
      }
      .task {
        viewModel.fetchBooks()
      }
      .refreshable {
        viewModel.fetchBooks()
      }
    }
  }
}

struct OnDemandBookListViewWithCombine_Previews: PreviewProvider {
  static var previews: some View {
    OnDemandBookListViewWithCombine()
  }
}
