//
//  BookEditView.swift
//  BookShelf
//
//  Created by Peter Friese on 05.03.21.
//

import SwiftUI

struct BookEditView: View {
  @Binding var book: Book
  @State var isISBNValid = false
  
  var body: some View {
    Form {
      TextField("Book title", text: $book.title)
      Image(book.largeCoverImageName)
        .resizable()
        .scaledToFit()
        .shadow(radius: 10)
        .padding()
      TextField("Author", text: $book.author)
      VStack(alignment: .leading) {
        if !isISBNValid {
          Text("ISBN is invalid")
            .font(.caption)
            .foregroundColor(.red)
        }
        TextField("ISBN", text: $book.isbn)
      }
      TextField("Pages", value: $book.pages, formatter: NumberFormatter())
      Toggle("Read", isOn: .constant(true))
    }
    .onChange(of: book.isbn) { value in
      self.isISBNValid = checkISBN(isbn: book.isbn)
    }
    .navigationTitle(book.title)
  }
  
}

struct BookEditView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      BookEditView(book: .constant(Book.samples[0]))
    }
    .preferredColorScheme(.dark)
  }
}
