//
//  ContentView.swift
//  BookShelf
//
//  Created by Peter Friese on 09.01.21.
//

import SwiftUI

struct ContentView: View {
  var books: [Book]
  var body: some View {
    List(books) { book in
      BookRowView(book: book)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ContentView(books: sampleBooks)
      ContentView(books: sampleBooks)
        .preferredColorScheme(.dark)
    }
  }
}

struct BookRowView: View {
  var book: Book
  var body: some View {
    HStack(alignment: .top) {
      Image(book.mediumCoverImageName)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(height: 90)
      VStack(alignment: .leading) {
        Text(book.title)
          .font(.headline)
        Text("by \(book.author)")
          .font(.subheadline)
      }
      Spacer()
    }
  }
}
