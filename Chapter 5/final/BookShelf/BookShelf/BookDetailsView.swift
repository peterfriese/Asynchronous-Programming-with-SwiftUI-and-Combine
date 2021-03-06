//
//  BookDetailsView.swift
//  BookShelf
//
//  Created by Peter Friese on 05.03.21.
//

import SwiftUI

struct BookDetailsView: View {
  @Binding var book: Book
  @State var showEditBookView = false
  
  var body: some View {
    Form {
      Text(book.title)
      Image(book.largeCoverImageName)
        .resizable()
        .scaledToFit()
        .shadow(radius: 10)
        .padding()
      Label(book.author, systemImage: "person.crop.rectangle")
      Label("\(book.isbn) pages", systemImage: "number")
      Label("\(book.pages) pages", systemImage: "book")
      Toggle("Read", isOn: .constant(true))
      Button(action: { showEditBookView.toggle() }) {
        Label("Edit", systemImage: "pencil")
      }
    }
    .sheet(isPresented: $showEditBookView) {
      BookEditView(bookEditViewModel: BookEditViewModel(book: self.$book))
    }
    .navigationTitle(book.title)
  }
}

struct BookDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      BookDetailsView(book: .constant(Book.samples[0]))
    }
    .preferredColorScheme(.dark)
  }
}
