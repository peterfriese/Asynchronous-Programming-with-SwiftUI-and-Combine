//
//  ContentView.swift
//  ViewModifiers
//
//  Created by Peter Friese on 11.06.22.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    Text("Hello, world!")
      .background(.red)
      .padding()
  }
}

struct ContentView2: View {
  var body: some View {
    Text("Hello, world!")
      .padding()
      .background(.red)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .previewLayout(.sizeThatFits)
    ContentView2()
      .previewLayout(.sizeThatFits)
  }
}
