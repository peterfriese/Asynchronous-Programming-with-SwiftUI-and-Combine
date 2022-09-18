//
//  ObservedObjectSampleScreen.swift
//  StateManagement
//
//  Created by Peter Friese on 09.02.21.
//

import SwiftUI

struct Book: Identifiable {
  var id = UUID().uuidString
  var title: String
  var author: String
  var pages: Int
}

extension Book {
  static var samples = [
    Book(title: "Changer", author: "Matt Gemmell", pages: 476),
    Book(title: "The Hitchhiker's Guide to the Galaxy", author: "Douglas Adams", pages: 224),
    Book(title: "Why we sleep", author: "Matthew Walker", pages: 368),
  ]
  
  static var samplesToAdd = [
    Book(title: "Indistractable", author: "Nir Eyal", pages: 273),
    Book(title: "The Swift Programming Language", author: "Apple, Inc", pages: 500),
    Book(title: "The Innovators", author: "Walter Isaacson", pages: 528)
  ]
  
}

class BooksListViewModel: ObservableObject {
  @Published var books: [Book]
  
  init(books: [Book]) {
    self.books = books
  }
}

struct ObservedObjectSampleScreen: View {
  @ObservedObject var viewModel: BooksListViewModel
  
  var body: some View {
    VStack(alignment: .leading) {
      Introduction(Text("By using @ObservedObject on a view, you can subscribe to changes to properties marked as @Published on @ObservableObjects. Tap the \(Image(systemName: "plus")) button to add a new book."))
      
      List(viewModel.books) { book in
        Text("\(book.title)")
      }
      .listStyle(PlainListStyle())
    }
    .navigationTitle("@ObservedObject")
    .toolbar {
      ToolbarItem {
        Button(action: addRandomBook) {
          Image(systemName: "plus")
        }
      }
    }
  }
  
  func addRandomBook() {
    let index = Int.random(in: 0..<Book.samplesToAdd.count)
    let book = Book.samplesToAdd[index]
    viewModel.books.append(book)
  }
}

struct ObservedObjectSampleScreen_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      ObservedObjectSampleScreen(viewModel: BooksListViewModel(books: Book.samples))
    }
  }
}
