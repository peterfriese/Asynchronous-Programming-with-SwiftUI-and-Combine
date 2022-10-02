//
//  SignUpFormViewModel.swift
//  SignUpForm
//
//  Created by Peter Friese on 18.01.22.
//

import SwiftUI
import Combine
import Navajo_Swift

// MARK: - View Model
class SignUpFormViewModel: ObservableObject {
  private var authenticationService = AuthenticationService()
  
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
      .map {
        print("Username length. \($0)")
        return $0.count >= 3
      }
      .eraseToAnyPublisher()
  }()
  
  private lazy var isUsernameAvailablePublisher: AnyPublisher<Bool, Never> = {
    $username
      .print("username")
      .debounce(for: 0.8, scheduler: RunLoop.main)
      .removeDuplicates()
      .flatMap { username -> AnyPublisher<Bool, Never> in
        self.authenticationService.checkUserNameAvailable(userName: username)
      }
      .receive(on: DispatchQueue.main)
      .share()
      .print("share")
      .eraseToAnyPublisher()
  }()
  
  enum UserNameValid {
    case valid
    case tooShort
    case notAvailable
  }
  
  private lazy var isUsernameValidPublisher: AnyPublisher<UserNameValid, Never> = {
    Publishers.CombineLatest(isUsernameLengthValidPublisher, isUsernameAvailablePublisher).map { longEnough, available in
      if !longEnough {
        return .tooShort
      }
      if !available {
        return .notAvailable
      }
      return .valid
    }
    .share()
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
    Publishers.CombineLatest(isUsernameValidPublisher, isPasswordValidPublisher)
      .map { ($0 == .valid) && $1 }
      .eraseToAnyPublisher()
  }()
  
  // remove this later?
  func isUsernameAvailable(username: String) {
    authenticationService.checkUserNameAvailableWithCLosure(userName: username) { result in
      if case let .success(isAvailable) = result {
        print("Available: \(isAvailable)")
      }
      else if case let .failure(error) = result {
        print(error)
      }
    }
  }
  
  init() {
    isFormValidPublisher
      .assign(to: &$isValid)
    
    isUsernameValidPublisher
      .map { valid in
        switch valid {
        case .tooShort:
          return "Username too short. Needs to be at least 3 characters."
        case .notAvailable:
          return "Username not available. Try a different one."
        default:
          return ""
        }
      }
      .receive(on: DispatchQueue.main)
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
