//
//  AuthenticationService.swift
//  SignUpForm
//
//  Created by Peter Friese on 28.12.21.
//

import Foundation
import Combine

struct UserAvailableMessage: Codable {
  var isAvailable: Bool
  var userName: String
}

struct AuthenticationService {
  func checkUserNameAvailable(userName: String) -> Bool {
    return !["peterfriese", "johnnyappleseed", "page", "johndoe"].contains(userName)
  }
  
  func checkUserNameAvailable2(userName: String) -> AnyPublisher<Bool, Never> {
    let urlString = "http://127.0.0.1:8080/isUserNameAvailable?userName=\(userName)"
    return URLSession.shared.dataTaskPublisher(for: URL(string: urlString)!)
      .map(\.data)
      .decode(type: UserAvailableMessage.self, decoder: JSONDecoder())
      .map { userAvailableMessage in
        userAvailableMessage.isAvailable
      }
      .replaceError(with: false)
      .eraseToAnyPublisher()
  }
}
