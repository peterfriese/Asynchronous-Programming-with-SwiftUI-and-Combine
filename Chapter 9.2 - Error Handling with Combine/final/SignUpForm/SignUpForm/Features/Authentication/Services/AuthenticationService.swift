//
//  AuthenticationService.swift
//  SignUpForm
//
//  Created by Peter Friese on 04.01.22.
//

import Foundation
import Combine
import UIKit

struct UserNameAvailableMessage: Codable {
  var isAvailable: Bool
  var userName: String
}

struct APIErrorMessage: Decodable {
  var error: Bool
  var reason: String
}

enum APIError: LocalizedError {
  /// Invalid request, e.g. invalid URL
  case invalidRequestError(String)
  
  /// Indicates an error on the transport layer, e.g. not being able to connect to the server
  case transportError(Error)
  
  /// Received an invalid response, e.g. non-HTTP result
  case invalidResponse
  
  /// Server-side validation error
  case validationError(String)
  
  /// The server sent data in an unexpected format
  case decodingError(Error)
  
  /// General server-side error. If `retryAfter` is set, the client can send the same request after the given time.
  case serverError(statusCode: Int, reason: String? = nil, retryAfter: String? = nil)

  var errorDescription: String? {
    switch self {
    case .invalidRequestError(let message):
      return "Invalid request: \(message)"
    case .transportError(let error):
      return "Transport error: \(error)"
    case .invalidResponse:
      return "Invalid response"
    case .validationError(let reason):
      return "Validation Error: \(reason)"
    case .decodingError:
      return "The server returned data in an unexpected format. Try updating the app."
    case .serverError(let statusCode, let reason, let retryAfter):
      return "Server error with code \(statusCode), reason: \(reason ?? "no reason given"), retry after: \(retryAfter ?? "no retry after provided")"
    }
  }
}

struct AuthenticationService {
  
  func checkUserNameAvailablePublisher(userName: String) -> AnyPublisher<Bool, Error> {
    guard let url = URL(string: "http://127.0.0.1:8080/isUserNameAvailable?userName=\(userName)") else {
      return Fail(error: APIError.invalidRequestError("URL invalid"))
        .eraseToAnyPublisher()
    }
    
    let dataTaskPublisher = URLSession.shared.dataTaskPublisher(for: url)
      // handle URL errors (most likely not able to connect to the server)
      .mapError { error -> Error in
        return APIError.transportError(error)
      }
    
      // handle all other errors
      .tryMap { (data, response) -> (data: Data, response: URLResponse) in
        print("Received response from server, now checking status code")
        
        guard let urlResponse = response as? HTTPURLResponse else {
          throw APIError.invalidResponse
        }
        
        if (200..<300) ~= urlResponse.statusCode {
        }
        else {
          let decoder = JSONDecoder()
          let apiError = try decoder.decode(APIErrorMessage.self, from: data)
          
          if urlResponse.statusCode == 400 {
            throw APIError.validationError(apiError.reason)
          }
          
          if (500..<600) ~= urlResponse.statusCode {
            let retryAfter = urlResponse.value(forHTTPHeaderField: "Retry-After")
            throw APIError.serverError(statusCode: urlResponse.statusCode, reason: apiError.reason, retryAfter: retryAfter)
          }

        }
        return (data, response)
      }

    return dataTaskPublisher
      .tryCatch { error -> AnyPublisher<(data: Data, response: URLResponse), Error> in
        if case APIError.serverError = error {
          return Just(Void())
            .delay(for: 3, scheduler: DispatchQueue.global())
            .flatMap { _ in
              return dataTaskPublisher
            }
            .print("before retry")
            .retry(10)
            .eraseToAnyPublisher()
        }
        throw error
      }
      .map(\.data)
//      .decode(type: UserNameAvailableMessage.self, decoder: JSONDecoder())
      .tryMap { data -> UserNameAvailableMessage in
        let decoder = JSONDecoder()
        do {
          return try decoder.decode(UserNameAvailableMessage.self, from: data)
        }
        catch {
          throw APIError.decodingError(error)
        }
      }
      .map(\.isAvailable)
//      .replaceError(with: false)
      .eraseToAnyPublisher()
  }
  
}
