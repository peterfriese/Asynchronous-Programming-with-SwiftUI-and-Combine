//
//  ContentView.swift
//  SignUpForm
//
//  Created by Peter Friese on 27.12.21.
//

import SwiftUI
import Combine

class SignUpFormViewModel: ObservableObject {
  // Input
  @Published var username: String = ""
  @Published var password: String = ""
  @Published var passwordConfirmation: String = ""
  
  // Output
  @Published var usernameMessage: String = ""
  @Published var passwordMessage: String = ""
  @Published var isValid: Bool = false
  
  init() {
    $username
      .map { $0.count >= 3 }
      .assign(to: &$isValid)
  }
}

struct SignUpForm: View {
  @StateObject var viewModel = SignUpFormViewModel()
  
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
      
      // Password
      Section {
        SecureField("Password", text: $viewModel.password)
        SecureField("Repeat password", text: $viewModel.passwordConfirmation)
      } footer: {
        Text(viewModel.passwordMessage)
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
  }
}

struct SignUpForm_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SignUpForm()
        .navigationTitle("Sign up")
    }
  }
}
