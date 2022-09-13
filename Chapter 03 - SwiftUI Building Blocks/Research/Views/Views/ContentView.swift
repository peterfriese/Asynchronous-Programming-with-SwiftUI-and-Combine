//
//  ContentView.swift
//  Views
//
//  Created by Peter Friese on 02.07.22.
//

import SwiftUI

struct EmphasizedLayout: ViewModifier {
  func body(content: Content) -> some View {
    content
      .background(Color.yellow)
      .border(Color.red)
  }
}

struct ContentView: View {

  var body: some View {
    HStack {
      ModifiedContent(content: Text("Hello"), modifier: EmphasizedLayout())
      Text("Hello, world!")
        .padding()

      Text("Hello, world!")
        .foregroundColor(.red)
        .font(.title)

      Image(systemName: "globe")
    }
    .dump()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
