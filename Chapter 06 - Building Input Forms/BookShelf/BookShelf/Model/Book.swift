//
//  Book.swift
//  BookShelf
//
//  Created by Peter Friese on 04/01/2021.
//

import Foundation

struct Book: Hashable, Identifiable {
  var id = UUID()
  var title: String
  var author: String
  var isbn: String
  var pages: Int
  var isRead: Bool = false
}

extension Book {
  var smallCoverImageName: String { return "\(isbn)-S" }
  var mediumCoverImageName: String { return "\(isbn)-M" }
  var largeCoverImageName: String { return "\(isbn)-L" }
}

extension Book {
  static let sampleBooks = [
    Book(title: "Changer", author: "Matt Gemmell", isbn: "9781916265202", pages: 476),
    Book(title: "SwiftUI for Absolute Beginners", author: "Jayant Varma", isbn: "9781484255155", pages: 200),
    Book(title: "Asynchronous Programming with SwiftUI and Combine", author: "Peter Friese", isbn: "9781484285718", pages: 451),
    Book(title: "Modern Concurrency on Apple Platforms", author: "Andy Ibanez", isbn: "9781484286944", pages: 368)
  ]

  static let sampleBook = sampleBooks[2]
}
