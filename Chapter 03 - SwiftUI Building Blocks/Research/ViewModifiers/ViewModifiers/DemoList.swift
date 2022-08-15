//
//  DemoList.swift
//  ViewModifiers
//
//  Created by Peter Friese on 11.06.22.
//

import SwiftUI

struct DemoList: View {
  var body: some View {
    List(0 ..< 5) { item in
      VStack(alignment: .leading) {
        Text("Hello, World!")
        Text("How are you today?")
      }
      .font(.system(.body, design: .monospaced))
    }
  }
}

struct DemoList_Previews: PreviewProvider {
  static var previews: some View {
    DemoList()
  }
}
