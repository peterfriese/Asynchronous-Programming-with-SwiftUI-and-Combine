//
//  OnDemandBookDetailsViewWithCombine.swift
//  WrappingExistingAPIsInCombine
//
//  Created by Peter Friese on 13.04.22.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

private class BookListViewModel: ObservableObject {
  @Published var book = Book.empty
  
  private var db = Firestore.firestore()
  
  func fetchBook() {
    db.collection("books").document("hitchhiker").getDocument()
      .tryMap { documentSnapshot in
        try documentSnapshot.data(as: Book.self)
      }
      .replaceError(with: Book.empty)
      .assign(to: &$book)
  }
}

struct OnDemandBookDetailsViewWithCombine: View {
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

struct OnDemandBookDetailsViewWithCombine_Previews: PreviewProvider {
  static var previews: some View {
    OnDemandBookDetailsViewWithCombine()
  }
}
