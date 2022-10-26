//
//  BooksViewModel.swift
//  BookShelf
//
//  Created by Peter Friese on 06.03.21.
//

import SwiftUI

class BooksViewModel: ObservableObject {
  @Published var books: [Book] = Book.sampleBooks
}
