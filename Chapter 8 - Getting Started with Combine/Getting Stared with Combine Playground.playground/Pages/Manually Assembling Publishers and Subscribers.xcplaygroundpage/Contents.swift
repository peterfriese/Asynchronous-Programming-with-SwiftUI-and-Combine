//: [<Previous](@previous)  [Home](Introduction)  [Next>](@next)

import Foundation
import Combine
import UIKit

enum OrderStatus: String {
  case placed
  case processing
  case delivered
}

extension Notification.Name {
  static let didUpdateOrderStatus = Notification.Name(rawValue: "didUpdateOrderStatus")
}

class Order {
  var status: OrderStatus
  var item: String
  
  init(item: String) {
    self.status = .placed
    self.item = item
  }
}

let sushi = Order(item: "Bento box #1")
let orderPublisher = NotificationCenter.Publisher(center: .default, name: .didUpdateOrderStatus, object: sushi)

let orderSubscriber = Subscribers.Sink<Notification, Never> { completion in
  //  print(completion)
  print("Received completion")
} receiveValue: { value in
  //  print(value.name)
  //  if let status = value.userInfo?["status"] as? OrderStatus {
  //    print(status.rawValue)
  //  }
  print("Received value: \(value)")
}
orderPublisher.subscribe(orderSubscriber)

NotificationCenter.default.publisher(for: .didUpdateOrderStatus, object: sushi)
  .sink { notifiaction in
    print("Received notification: \(notifiaction)")
  }


let info = [
  "newStatus": OrderStatus.processing,
]
NotificationCenter.default.post(name: .didUpdateOrderStatus, object: sushi, userInfo: info)


//: [<Previous](@previous)  [Home](Introduction)  [Next>](@next)
