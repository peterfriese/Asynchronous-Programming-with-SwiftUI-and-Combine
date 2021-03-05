//
//  ContentView.swift
//  Hello SwiftUI
//
//  Created by Peter Friese on 18/12/2020.
//

import SwiftUI

struct ContentView: View {
  @State var name = ""
  
  var body: some View {
    VStack {
      TextField("Enter your name", text: $name)
        .padding(.all)
        .border(Color.black, width: 1)
        .padding(.all)
      Text("Hello, \(name)!")
        .font(.title)
        .foregroundColor(Color.pink)
        .padding()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
