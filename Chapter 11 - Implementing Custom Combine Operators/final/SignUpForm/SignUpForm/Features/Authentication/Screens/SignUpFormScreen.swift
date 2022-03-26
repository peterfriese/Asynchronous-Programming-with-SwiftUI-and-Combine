//
//  ContentView.swift
//  SignUpForm
//
//  Created by Peter Friese on 27.12.21.
//

import SwiftUI
import Combine

// MARK: - View

struct SignUpScreen: View {
  @StateObject private var viewModel = SignUpScreenViewModel()
  
  var body: some View {
    Form {
      // Username
      Section {
        TextField("Username", text: $viewModel.username)
          .autocapitalization(.none)
          .disableAutocorrection(true)
      } footer: {
        Text(viewModel.usernameMessage)
          .foregroundColor(.red)
      }
      
      // Submit button
      Section {
        Button("Sign up") {
          print("Signing up as \(viewModel.username)")
        }
        .disabled(!viewModel.isValid)
      }
    }
    
    // show update dialog
    .alert("Please update", isPresented: $viewModel.showUpdateDialog, actions: {
      Button("Upgrade") {
        // open App Store listing page for the app
      }
      Button("Not now", role: .cancel) { }
    }, message: {
      Text("It looks like you're using an older version of this app. Please update your app.")
    })

  }
}

struct SignUpScreen_Previews: PreviewProvider {
  static var previews: some View {
    SignUpScreen()
  }
}
