//
//  Book.swift
//  BookShelf
//
//  Created by Peter Friese on 09.01.21.
//

import Foundation

struct Book: Identifiable {
  var id = UUID().uuidString
  var title: String
  var author: String
  var isbn: String
  var pages: Int
}

extension Book {
  var smallCoverImageName: String { return "\(isbn)-S" }
  var mediumCoverImageName: String { return "\(isbn)-M" }
  var largeCoverImageName: String { return "\(isbn)-L" }
}

let sampleBooks = [
  Book(title: "Changer", author: "Matt Gemmell", isbn: "9781916265202", pages: 476),
  Book(title: "SwiftUI for Absolute Beginners", author: "Jayant Varma", isbn: "9781484255155", pages: 200),
  Book(title: "Why we sleep", author: "Matthew Walker", isbn: "9780141983769", pages: 368)
]
