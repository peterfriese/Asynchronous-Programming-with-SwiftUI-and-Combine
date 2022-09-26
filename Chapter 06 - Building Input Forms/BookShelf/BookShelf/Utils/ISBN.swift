//
//  ISBN.swift
//  BookShelf
//
//  Created by Peter Friese on 06.03.21.
//

import Foundation

// From http://rosettacode.org/wiki/ISBN13_check_digit#Swift
func checkISBN(isbn: String) -> Bool {
  guard !isbn.isEmpty else {
    return false
  }
  
  let sum = isbn
    .compactMap { $0.wholeNumberValue }
    .enumerated()
    .map { $0.offset & 1 == 1 ? 3 * $0.element : $0.element }
    .reduce(0, +)
  
  return sum % 10 == 0
}
