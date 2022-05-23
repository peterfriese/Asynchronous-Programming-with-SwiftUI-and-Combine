//
//  ButtonStyles.swift
//  SwiftUICombineSchedulers
//
//  Created by Peter Friese on 14.05.22.
//

import SwiftUI

struct ActionButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
      .frame(maxWidth: .infinity)
      .controlSize(.large)
      .foregroundColor(.white)
      .background {
        RoundedRectangle(cornerRadius: 8)
          .fill(Color(UIColor.systemBlue))
      }
      .padding()
  }
}

extension ButtonStyle where Self == ActionButtonStyle {
    static var action: Self {
        return .init()
    }
}

