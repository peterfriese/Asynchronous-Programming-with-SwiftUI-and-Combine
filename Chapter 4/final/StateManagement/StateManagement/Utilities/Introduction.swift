//
//  Introduction.swift
//  StateManagement
//
//  Created by Peter Friese on 09.02.21.
//

import SwiftUI

struct Introduction: View {
  var text: Text
  
  init(_ text: String) {
    self.text = Text(text)
  }
  
  init(_ text: Text) {
    self.text = text
  }
  
  var body: some View {
    text
      .font(.subheadline)
      .foregroundColor(Color(UIColor.secondaryLabel))
      .padding()
  }
}

struct Introduction_Previews: PreviewProvider {
  static var previews: some View {
    Introduction(
      """
      This is a multiline string
      Just checking ount
      """
    )
    .previewLayout(.sizeThatFits)
  }
}
