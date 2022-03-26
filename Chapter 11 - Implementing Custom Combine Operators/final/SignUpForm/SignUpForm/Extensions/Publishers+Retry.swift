//
//  Publishers+Retry.swift
//  SignUpForm
//
//  Created by Peter Friese on 06.03.22.
//

import Foundation
import Combine

enum RetryStrategy {
  case retry(retries: Int = 2, delay: Int = 3)
  case skip
}

extension Publisher {
  func retry<T, E>(_ strategy: @escaping ((E) -> RetryStrategy)) -> Publishers.TryCatch<Self, AnyPublisher<T, E>> where T == Self.Output, E == Self.Failure {
    return self.tryCatch { error -> AnyPublisher<T, E> in
      let strategy = strategy(error)
      if case .retry(let retries, let delay) = strategy {
        return Just(Void())
          .delay(for: .init(integerLiteral: delay), scheduler: DispatchQueue.global())
          .flatMap { _ in
            return self
          }
          .retry(retries)
          .eraseToAnyPublisher()
      }
      else {
        throw error
      }
    }
  }
  
  func retry<T, E>(_ retries: Int, withDelay: @escaping ((E) -> Int)) -> Publishers.TryCatch<Self, AnyPublisher<T, E>> where T == Self.Output, E == Self.Failure {
    return self.tryCatch { error -> AnyPublisher<T, E> in
      let delay = withDelay(error)
      return Just(Void())
        .delay(for: .init(integerLiteral: delay), scheduler: DispatchQueue.global())
        .flatMap { _ in
          return self
        }
        .retry(retries)
        .eraseToAnyPublisher()
    }
  }
  
  func retry<T, E>(_ retries: Int, withDelay delay: Int, condition: ((E) -> Bool)? = nil) -> Publishers.TryCatch<Self, AnyPublisher<T, E>> where T == Self.Output, E == Self.Failure {
    return self.tryCatch { error -> AnyPublisher<T, E> in
      if condition?(error) == true {
        return Just(Void())
          .delay(for: .init(integerLiteral: delay), scheduler: DispatchQueue.global())
          .flatMap { _ in
            return self
          }
          .retry(retries)
          .eraseToAnyPublisher()
      }
      else {
        throw error
      }
    }
  }
  
  func retry<T, E>(_ retries: Int, withBackoff initialBackoff: Int, condition: ((E) -> Bool)? = nil) -> Publishers.TryCatch<Self, AnyPublisher<T, E>> where T == Self.Output, E == Self.Failure {
    return self.tryCatch { error -> AnyPublisher<T, E> in
      if condition?(error) ?? true {
        var backOff = initialBackoff
        return Just(Void())
          .flatMap { _ -> AnyPublisher<T, E> in
            let result = Just(Void())
              .delay(for: .init(integerLiteral: backOff), scheduler: DispatchQueue.global())
              .flatMap { _ in
                return self
              }
            backOff = backOff * 2
            return result.eraseToAnyPublisher()
          }
          .retry(retries - 1)
          .eraseToAnyPublisher()
      }
      else {
        throw error
      }
    }
  }
}
