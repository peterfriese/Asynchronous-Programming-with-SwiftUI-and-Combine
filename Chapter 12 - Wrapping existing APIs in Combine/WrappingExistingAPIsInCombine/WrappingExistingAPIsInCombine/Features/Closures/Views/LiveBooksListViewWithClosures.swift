//
//  LiveBooksListViewWithClosures.swift
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
  @Published var numberOfBooks = 0
  @Published var errorMessage: String?
  
  private var db = Firestore.firestore()
  private var listenerRegistration: ListenerRegistration?
  
  init() {
    $books.map { books in
      books.count
    }
    .assign(to: &$numberOfBooks)
  }
  
  public func unsubscribe() {
    if listenerRegistration != nil {
      listenerRegistration?.remove()
      listenerRegistration = nil
    }
  }
  
  func subscribe() {
    if listenerRegistration == nil {
      listenerRegistration = db.collection("books")
        .addSnapshotListener { [weak self] (querySnapshot, error) in
          guard let documents = querySnapshot?.documents else {
            self?.errorMessage = "No documents in 'books' collection"
            return
          }
          
          self?.books = documents.compactMap { queryDocumentSnapshot in
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
}

struct LiveBooksListViewWithClosures: View {
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

struct LiveBooksListViewWithClosures_Previews: PreviewProvider {
  static var previews: some View {
    LiveBooksListViewWithClosures()
  }
}


