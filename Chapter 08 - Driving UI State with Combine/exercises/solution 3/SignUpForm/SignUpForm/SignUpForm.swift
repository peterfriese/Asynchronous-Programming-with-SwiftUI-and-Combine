//
//  ContentView.swift
//  SignUpForm
//
//  Created by Peter Friese on 27.12.21.
//

import SwiftUI
import Combine
import Navajo_Swift

// MARK: - View Model
private class SignUpFormViewModel: ObservableObject {
  
  // MARK: Input
  @Published var username: String = ""
  @Published var password: String = ""
  @Published var passwordConfirmation: String = ""
  
  // MARK: Output
  @Published var usernameMessage: String = ""
  @Published var passwordMessage: String = ""
  @Published var passwordStrengthValue: Double = 0.0
  @Published var passwordStrengthColor: Color = .red
  @Published var isValid: Bool = false
  
  // MARK: Username validattion
  private lazy var isUsernameLengthValidPublisher: AnyPublisher<Bool, Never> = {
    $username
      .map { $0.count >= 3 }
      .eraseToAnyPublisher()
  }()
  
  // MARK: Password validation
  private lazy var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> = {
    $password
      .map(\.isEmpty)
      // equivalent to
      // .map { $0.isEmpty }
      .eraseToAnyPublisher()
  }()
  
  private lazy var isPasswordLengthValidPublisher: AnyPublisher<Bool, Never> = {
    $password
      .map { $0.count >= 8 }
      .eraseToAnyPublisher()
  } ()
  
  private lazy var isPasswordMatchingPublisher: AnyPublisher<Bool, Never> = {
    Publishers.CombineLatest($password, $passwordConfirmation)
      .map(==)
      // equivalent to
      // .map { $0 == $1 }
      .eraseToAnyPublisher()
  }()
  
  private lazy var passwordStrengthPublisher: AnyPublisher<PasswordStrength, Never> = {
    $password
      .map(Navajo.strength(ofPassword:))
      .eraseToAnyPublisher()
  }()
  
  private lazy var isPasswordStrongEnoughPublisher: AnyPublisher<Bool, Never> = {
     passwordStrengthPublisher
      .map { passwordStrength in
        switch passwordStrength {
        case .veryWeak, .weak:
          return false
        case .reasonable, .strong, .veryStrong:
          return true
        }
      }
      .eraseToAnyPublisher()
  }()
  
  private lazy var isPasswordValidPublisher: AnyPublisher<Bool, Never> = {
    Publishers.CombineLatest4(isPasswordEmptyPublisher, isPasswordLengthValidPublisher, isPasswordStrongEnoughPublisher, isPasswordMatchingPublisher)
      .map { !$0 && $1 && $2 && $3 }
      .eraseToAnyPublisher()
  }()
  
  // MARK: Form validation
  private lazy var isFormValidPublisher: AnyPublisher<Bool, Never> = {
    Publishers.CombineLatest(isUsernameLengthValidPublisher, isPasswordValidPublisher)
      .map { $0 && $1 }
      .eraseToAnyPublisher()
  }()
  
  init() {
    isFormValidPublisher
      .assign(to: &$isValid)

    isUsernameLengthValidPublisher
      .map { $0 ? "" : "Username too short. Needs to be at least 3 characters." }
      .assign(to: &$usernameMessage)
    
    passwordStrengthPublisher
      .map {
        switch $0 {
        case .veryWeak: return 0.25
        case .weak: return 0.35
        case .reasonable: return 0.5
        case .strong: return 0.75
        case .veryStrong: return 1
        }
      }
      .assign(to: &$passwordStrengthValue)
    
    passwordStrengthPublisher
      .map {
        switch $0 {
        case .veryWeak: return .red
        case .weak: return .red
        case .reasonable: return .orange
        case .strong: return .yellow
        case .veryStrong: return .green
        }
      }
      .assign(to: &$passwordStrengthColor)


    Publishers.CombineLatest4(isPasswordEmptyPublisher, isPasswordLengthValidPublisher, isPasswordStrongEnoughPublisher, isPasswordMatchingPublisher)
      .map { isPasswordEmpty, isPasswordLengthValid, isPasswordStrongEnough, isPasswordMatching in
        if isPasswordEmpty {
          return "Password must not be empty"
        }
        else if !isPasswordLengthValid {
          return "Password needs to be at least 8 characters"
        }
        else if !isPasswordStrongEnough {
          return "Password not strong enough"
        }
        else if !isPasswordMatching {
          return "Passwords do not match"
        }
        return ""
      }
      .assign(to: &$passwordMessage)
  }
}

// MARK: - View
struct SignUpForm: View {
  @StateObject private var viewModel = SignUpFormViewModel()
  
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
        VStack(alignment: .leading) {
          ProgressView(value: viewModel.passwordStrengthValue, total: 1)
            .tint(viewModel.passwordStrengthColor)
            .progressViewStyle(.linear)
          Text(viewModel.passwordMessage)
            .foregroundColor(.red)
        }
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

// MARK: - Preview
struct SignUpForm_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      SignUpForm()
        .navigationTitle("Sign up")
    }
  }
}
