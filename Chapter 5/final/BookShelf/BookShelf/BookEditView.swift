//
//  BookEditView.swift
//  BookShelf
//
//  Created by Peter Friese on 05.03.21.
//

import SwiftUI

class BookEditViewModel: ObservableObject {
  @Binding var book: Book
  
  var isISBNValid: Bool {
    checkISBN(isbn: book.isbn)
  }
  
  init(book: Binding<Book>) {
    self._book = book
  }
}

struct BookEditView: View {
  @ObservedObject var bookEditViewModel: BookEditViewModel
  
  var body: some View {
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
      Toggle("Read", isOn: .constant(true))
    }
    .navigationTitle(bookEditViewModel.book.title)
  }
  
}

struct BookEditView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      BookEditView(bookEditViewModel: BookEditViewModel(book: .constant(Book.samples[0])))
    }
    .preferredColorScheme(.dark)
  }
}
