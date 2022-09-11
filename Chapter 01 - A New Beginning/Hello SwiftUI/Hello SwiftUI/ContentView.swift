//
//  ContentView.swift
//  Hello SwiftUI
//
//  Created by Peter Friese on 11.09.22.
//

import SwiftUI

struct ContentView: View {
  @State var name = ""
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundColor(.accentColor)
      TextField("Enter your name here", text: $name)
        .padding(.all)
        .border(Color.pink, width: 1)
        .padding(.all)
      Text("Hello, \(name)!")
        .font(.title)
        .foregroundColor(Color.pink)
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
