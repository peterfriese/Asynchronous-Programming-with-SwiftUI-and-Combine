//
//  Book.swift
//  BookShelf
//
//  Created by Peter Friese on 11.09.22.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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

extension Book {
  static let sampleBooks = [
    Book(title: "Changer", author: "Matt Gemmell", isbn: "9781916265202", pages: 476),
    Book(title: "SwiftUI for Absolute Beginners", author: "Jayant Varma", isbn: "9781484255155", pages: 200),
    Book(title: "Asynchronous Programming with SwiftUI and Combine", author: "Peter Friese", isbn: "9781484285718", pages: 367),
    Book(title: "Modern Concurrency on Apple Platforms", author: "Andy Ibanez", isbn: "9781484286944", pages: 368)
  ]
}
