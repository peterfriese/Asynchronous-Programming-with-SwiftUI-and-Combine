//
//  ContentView.swift
//  FormsExamples
//
//  Created by Peter Friese on 02.03.21.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    Form {
      Text("Asynchronous Programming with SwiftUI and Combine")
        .font(.headline).foregroundColor(.red)
      Image("book-cover-combine")
      Label("Peter Friese", systemImage: "person.crop.rectangle")
      Label("451 pages", systemImage: "book")
      Toggle("Read", isOn: .constant(true))
      Button(action: {}) {
        Label("Share", systemImage: "square.and.arrow.up")
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
