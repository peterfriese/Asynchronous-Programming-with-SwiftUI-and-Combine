//
//  NavigationTitleDemo.swift
//  ViewModifiers
//
//  Created by Peter Friese on 11.06.22.
//

import SwiftUI

struct NavigationTitleDemo: View {
  var body: some View {
    NavigationView {
      HStack {
        Text("Hello, World!")
          .navigationTitle("Inner title")
      }
      .navigationTitle("Outer title")
    }
  }
}

struct NavigationTitleDemo_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      NavigationTitleDemo()
    }
  }
}
