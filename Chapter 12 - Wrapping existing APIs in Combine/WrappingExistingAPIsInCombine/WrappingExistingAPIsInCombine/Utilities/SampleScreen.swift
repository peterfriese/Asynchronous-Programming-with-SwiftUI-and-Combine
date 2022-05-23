//
//  SampleScreen.swift
//  WrappingExistingAPIsInCombine
//
//  Created by Peter Friese on 12.04.22.
//

import SwiftUI

struct SampleScreen<Content: View>: View {
  var title: String
  var introduction: Text
  var content: () -> Content
  
  init(_ title: String, introduction: String, @ViewBuilder content: @escaping () -> Content) {
    self.title = title
    self.introduction = Text(introduction)
    self.content = content
  }
  
  init(_ title: String, _ introduction: Text, @ViewBuilder content: @escaping () -> Content) {
    self.title = title
    self.introduction = introduction
    self.content = content
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      introduction
        .font(.subheadline)
        .foregroundColor(Color(UIColor.secondaryLabel))
        .padding()
      content()
    }
    .navigationBarTitle(title)
  }
}

struct SampleScreen_Previews: PreviewProvider {
  static let multiLineIntro =
    """
This is a multiline string
Just checking out
Third line.
"""
  static var previews: some View {
    NavigationView {
      SampleScreen("Demo",
                   introduction: multiLineIntro
      ) {
        List {
          Text("Sample")
        }
      }
    }
    .previewLayout(.sizeThatFits)
  }
}
