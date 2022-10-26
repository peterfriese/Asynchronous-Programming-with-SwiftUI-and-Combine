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
      .map { checkISBN(isbn: $0.isbn) }
      .assign(to: &$isISBNValid)
  }
}

struct BookEditView: View {
  @Binding var book: Book
  @ObservedObject var bookEditViewModel: BookEditViewModel
  @Environment(\.dismiss) var dismiss
  
  init(book: Binding<Book>) {
    self._book = book
    self.bookEditViewModel = BookEditViewModel(book: book.wrappedValue)
  }
  
  func cancel() {
    dismiss()
  }
  
  func save() {
    self.book = bookEditViewModel.book
    dismiss()
  }
  
  var body: some View {
    NavigationStack {
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
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button(action: cancel) {
            Text("Cancel")
          }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: save) {
            Text("Save")
          }
        }
      }
    }
  }
}

struct BookEditView_Previews: PreviewProvider {
  static var previews: some View {
    BookEditView(book: .constant(Book.sampleBooks[0]))
  }
}
