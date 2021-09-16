//: [<Previous](@previous)  [Home](Introduction)  [Next>](@next)

import Foundation
import Combine

// create the order
let pizzaOrder = Order()

let pizzaOrderPublisher = NotificationCenter.default.publisher(for: .didUpdateOrderStatus, object: pizzaOrder)
pizzaOrderPublisher.sink { notification in
  print(notification)
  dump(notification)
}

// the following code won't compile, so we need to use an operator to convert the `Notification` to an `OrderStatus`
//pizzaOrderPublisher
//  .assign(to: \.status, on: pizzaOrder)

pizzaOrderPublisher
  .map { notification in
    notification.userInfo?["status"] as? OrderStatus ?? OrderStatus.placing
  }
  .sink { orderStatus in
    print("Order status [\(orderStatus)]")
  }

pizzaOrderPublisher
  .map { notification in
    notification.userInfo?["status"] as? OrderStatus ?? OrderStatus.placing
  }
  .assign(to: \.status, on: pizzaOrder)

pizzaOrderPublisher
  .compactMap { notification in
    notification.userInfo?["status"] as? OrderStatus
  }
  .assign(to: \.status, on: pizzaOrder)

// once the user is ready to place the order
NotificationCenter.default.post(name: .didUpdateOrderStatus, object: pizzaOrder, userInfo: ["status": OrderStatus.processing])
NotificationCenter.default.post(name: .didUpdateOrderStatus, object: pizzaOrder, userInfo: ["status": OrderStatus.delivered])

print("Order: \(pizzaOrder.status)")

//: [<Previous](@previous)  [Home](Introduction)  [Next>](@next)
