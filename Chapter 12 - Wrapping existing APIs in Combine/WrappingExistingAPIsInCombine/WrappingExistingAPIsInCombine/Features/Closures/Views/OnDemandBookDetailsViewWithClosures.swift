//
//  OnDemandBookDetailsViewWithClosures.swift
//  WrappingExistingAPIsInCombine
//
//  Created by Peter Friese on 14.04.22.
//

import SwiftUI

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

private class BookListViewModel: ObservableObject {
  @Published var book = Book.empty
  @Published var errorMessage: String?
  
  private var db = Firestore.firestore()
  
  fileprivate func fetchBook() {
    let docRef = db.collection("books").document("hitchhiker")
    
    docRef.getDocument(as: Book.self) { result in
      switch result {
      case .success(let book):
        // A Book value was successfully initialized from the DocumentSnapshot.
        self.book = book
        self.errorMessage = nil
      case .failure(let error):
        // A Book value could not be initialized from the DocumentSnapshot.
        self.errorMessage = "Error decoding document: \(error.localizedDescription)"
      }
    }
  }
}

struct OnDemandBookDetailsViewWithClosures: View {
  @StateObject private var viewModel = BookListViewModel()
  
  var body: some View {
    SampleScreen("Fetch document once",
                 introduction: "This screen fetches a single document once. \n\n"
                 + "You can also pull down to refresh.") {
      Form {
        Text(viewModel.book.title)
        Text(viewModel.book.author)
        Text("\(viewModel.book.numberOfPages)")
      }
      .task {
        viewModel.fetchBook()
      }
      .refreshable {
        viewModel.fetchBook()
      }
    }
  }
}

struct OnDemandBookDetailsViewWithClosures_Previews: PreviewProvider {
  static var previews: some View {
    OnDemandBookDetailsViewWithClosures()
  }
}
