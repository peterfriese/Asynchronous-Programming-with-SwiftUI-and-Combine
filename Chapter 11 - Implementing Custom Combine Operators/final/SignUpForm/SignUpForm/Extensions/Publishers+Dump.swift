//
//  Publishers+Dump.swift
//  SignUpForm
//
//  Created by Peter Friese on 06.03.22.
//

import Foundation
import Combine

extension Publisher {
  func dump() -> AnyPublisher<Self.Output, Self.Failure> {
    handleEvents(receiveOutput:  { value in
      Swift.dump(value)
    })
    .eraseToAnyPublisher()
  }
}
