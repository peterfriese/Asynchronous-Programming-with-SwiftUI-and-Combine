//
//  BookEditView.swift
//  BookShelf
//
//  Created by Peter Friese on 05.03.21.
//

import SwiftUI

class BookEditViewModel: ObservableObject {
  @Published var book: Book
  @Published var isISBNValid: Bool = true
  
  init(book: Book) {
    self.book = book
    
    self.$book
      .map { book in
        return checkISBN(isbn: book.isbn)
      }
      .assign(to: &$isISBNValid)
  }
}

struct BookEditView: View {
  @ObservedObject var bookEditViewModel: BookEditViewModel
  @Environment(\.presentationMode) var presentationMode
  
  private var commit: ((Book) -> Void)?
  
  init(book: Book, commit: ((Book) -> Void)? = nil) {
    self.bookEditViewModel = BookEditViewModel(book: book)
    self.commit = commit
  }
  
  func cancel() {
    presentationMode.wrappedValue.dismiss()
  }
  
  func save() {
    if let commit = commit {
      commit(bookEditViewModel.book)
    }
    presentationMode.wrappedValue.dismiss()
  }
  
  var body: some View {
    NavigationView {
      Form {
        TextField("Book title", text: $bookEditViewModel.book.title)
        Image(bookEditViewModel.book.largeCoverImageName)
          .resizable()
          .scaledToFit()
          .shadow(radius: 10)
          .padding()
        TextField("Author", text: $bookEditViewModel.book.author)
        VStack(alignment: .leading) {
          if !bookEditViewModel.isISBNValid {
            Text("ISBN is invalid")
              .font(.caption)
              .foregroundColor(.red)
          }
          TextField("ISBN", text: $bookEditViewModel.book.isbn)
        }
        TextField("Pages", value: $bookEditViewModel.book.pages, formatter: NumberFormatter())
        Toggle("Read", isOn: $bookEditViewModel.book.isRead)
      }
      .navigationTitle(bookEditViewModel.book.title)
      .navigationBarItems(leading:
                            Button(action: cancel) {
                              Text("Cancel")
                            },
                          trailing:
                            Button(action: save) {
                              Text("Save")
                            })
    }
  }
  
}

struct BookEditView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      BookEditView(book: Book.samples[0])
    }
    .preferredColorScheme(.dark)
  }
}
