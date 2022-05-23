//
//  BookListViewWithClosures.swift
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
  
  func fetchBooks() {
    db.collection("books").getDocuments { querySnapshot, error in
      guard let documents = querySnapshot?.documents else {
        return
      }
      
      self.books = documents.compactMap { [weak self] queryDocumentSnapshot in
        let result = Result { try queryDocumentSnapshot.data(as: Book.self) }
        switch result {
        case .success(let book):
          // A Book value was successfully initialized from the DocumentSnapshot.
          self?.errorMessage = nil
          return book
        case .failure(let error):
          // A Book value could not be initialized from the DocumentSnapshot.
          self?.errorMessage = "\(error.localizedDescription)"
          return nil
        }
      }
    }
  }
}

struct OnDemandBookListViewWithClosures: View {
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

struct OnDemandBookListViewWithClosures_Previews: PreviewProvider {
  static var previews: some View {
    OnDemandBookListViewWithClosures()
  }
}
