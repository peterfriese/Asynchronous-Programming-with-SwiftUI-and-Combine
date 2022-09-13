//
//  View+Dump.swift
//  Views
//
//  Created by Peter Friese on 02.07.22.
//

import Foundation
import SwiftUI

extension View {
  func dump() -> Self {
    Swift.dump(Mirror(reflecting: self), indent: 2, maxDepth: 10, maxItems: 10)
    return self
  }
}
