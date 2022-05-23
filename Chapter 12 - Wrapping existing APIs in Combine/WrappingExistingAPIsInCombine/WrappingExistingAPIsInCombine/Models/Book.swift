//
//  Book.swift
//  WrappingExistingAPIsInCombine
//
//  Created by Peter Friese on 12.04.22.
//

import Foundation
import FirebaseFirestoreSwift

struct Book: Codable, Identifiable {
  @DocumentID var id: String?
  var title: String
  var numberOfPages: Int
  var author: String
}

extension Book {
  static let empty = Book(title: "", numberOfPages: 0, author: "")
}
