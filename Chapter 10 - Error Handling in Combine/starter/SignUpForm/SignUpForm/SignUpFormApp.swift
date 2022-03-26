//
//  SignUpFormApp.swift
//  SignUpForm
//
//  Created by Peter Friese on 27.12.21.
//

import SwiftUI

@main
struct SignUpFormApp: App {
  var body: some Scene {
    WindowGroup {
      NavigationView {
        SignUpFormScreen()
          .navigationTitle("Sign up")
      }
    }
  }
}
