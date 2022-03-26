//: [<Previous](@previous)  [Home](Introduction)  [Next>](@next)

import Foundation
import Combine

let answerPublisher = Just(42)

let answerSubscriber = Subscribers.Sink<Int, Never> { completion in
  print("Received completion")
} receiveValue: { value in
  print("I received value \(value) from publisher")
}

answerPublisher.subscribe(answerSubscriber)


let answerSubscription = answerPublisher.sink { value in
  print("Received value \(value) from publisher")
}


//: [<Previous](@previous)  [Home](Introduction)  [Next>](@next)
