//
//  BookEditView.swift
//  BookShelf
//
//  Created by Peter Friese on 05.03.21.
//

import SwiftUI

struct BookEditView: View {
  @Binding var book: Book
  
  var body: some View {
    Form {
      TextField("Book title", text: $book.title)
      Image(book.largeCoverImageName)
        .resizable()
        .scaledToFit()
        .shadow(radius: 10)
        .padding()
      TextField("Author", text: $book.author)
      TextField("Pages", value: $book.pages, formatter: NumberFormatter())
      Toggle("Read", isOn: .constant(true))
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
