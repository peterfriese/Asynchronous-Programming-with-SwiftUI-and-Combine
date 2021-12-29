//
//  ContentView.swift
//  SignUpForm
//
//  Created by Peter Friese on 27.12.21.
//

import SwiftUI
import Combine
import Navajo_Swift

class SignUpFormViewModel: ObservableObject {
  
  // Input
  @Published var username: String = ""
  @Published var password: String = ""
  @Published var passwordConfirmation: String = ""
  
  // Output
  @Published var usernameMessage: String = ""
  @Published var passwordMessage: String = ""
  @Published var isValid: Bool = false
  
  private var isUsernameLengthValidPublisher: AnyPublisher<Bool, Never> {
    $username
      .map { username in
        username.count >= 3
      }
      .eraseToAnyPublisher()
  }
  
  enum UserNameValid {
    case valid
    case tooShort
    case notAvailable
  }
  
  private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
    $password
      .map(\.isEmpty)
//      .map { $0.isEmpty }
      .eraseToAnyPublisher()
  }
  
  private var isPasswordMatching: AnyPublisher<Bool, Never> {
    Publishers.CombineLatest($password, $passwordConfirmation)
      .map { $0 == $1 }
      .eraseToAnyPublisher()
  }
  
  private var passwordStrengthPublisher: AnyPublisher<PasswordStrength, Never> {
    $password
      .map(Navajo.strength(ofPassword:))
//      .map { password in
//        Navajo.strength(ofPassword: password)
//      }
      .eraseToAnyPublisher()
  }
  
  private var isPasswordStrongEnoughPublisher: AnyPublisher<Bool, Never> {
    passwordStrengthPublisher
      .map { strength in
        switch strength {
        case .reasonable, .strong, .veryStrong:
          return true
        default:
          return false
        }
      }
      .eraseToAnyPublisher()
  }
  
  enum PasswordCheck {
    case valid
    case empty
    case noMatch
    case notStrongEnough
  }
  
  private var isPasswordValidPublisher: AnyPublisher<PasswordCheck, Never> {
    Publishers.CombineLatest3(isPasswordEmptyPublisher, isPasswordMatching, isPasswordStrongEnoughPublisher)
      .map { passwordIsEmpty, passwordsMatching, passwordIsStrongEnough in
        if (passwordIsEmpty) {
          return .empty
        }
        else if (!passwordIsStrongEnough) {
          return .notStrongEnough
        }
        else if (!passwordsMatching) {
          return .noMatch
        }
        else {
          return .valid
        }
      }
      .eraseToAnyPublisher()
  }
  
  private var isFormValidPublisher: AnyPublisher<Bool, Never> {
    Publishers.CombineLatest(isUsernameLengthValidPublisher, isPasswordValidPublisher)
      .map { usernameLengthIsValid, passwordIsValid in
        return usernameLengthIsValid && (passwordIsValid == .valid)
      }
      .eraseToAnyPublisher()
  }
  
  init() {
    isFormValidPublisher
      .receive(on: DispatchQueue.main)
      .assign(to: &$isValid)
    
    isUsernameLengthValidPublisher
      .map { $0 ? "" : "Username too short. Needs to be at least 3 characters." }
      .receive(on: DispatchQueue.main)
      .assign(to: &$usernameMessage)
    
    isPasswordValidPublisher
      .map { passwordCheck in
        switch passwordCheck {
        case .empty:
          return "Password must not be empty"
        case .noMatch:
          return "Passwords don't match"
        case .notStrongEnough:
          return "Password not strong enough"
        default:
          return ""
        }
      }
      .receive(on: DispatchQueue.main)
      .assign(to: &$passwordMessage)
    
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
