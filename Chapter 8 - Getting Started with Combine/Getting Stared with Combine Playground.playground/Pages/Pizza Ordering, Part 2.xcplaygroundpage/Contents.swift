//: [<Previous](@previous)  [Home](Introduction)  [Next>](@next)

import Foundation
import Combine

let margheritaOrder = Order(toppings: [
  Topping("tomatoes", isVeg: true),
  Topping("mozarella", isVeg: true),
  Topping("basil", isVeg: true)
])

let margheritaOrderPublisher = NotificationCenter.default.publisher(for: .didUpdateOrderStatus, object: margheritaOrder)
margheritaOrderPublisher
  .compactMap { notification in
    notification.userInfo?["status"] as? OrderStatus
  }
  .assign(to: \.status, on: margheritaOrder)

let extraToppingPublisher = NotificationCenter.default.publisher(for: .addTopping, object: margheritaOrder)
extraToppingPublisher
  .compactMap { notification in
    notification.userInfo?["extra"] as? Topping
  }
  .filter{ topping in
    topping.isVeg
  }
  .filter { $0.isVeg }
  .prefix(3)
  .prefix(while: { topping in
    margheritaOrder.status == .placing
  })
  .sink { value in
    if var toppings = margheritaOrder.toppings {
      toppings.append(value)
      print("Adding \(value.name)")
      print("Your order now contains \(toppings.count) toppings")
    }
  }

NotificationCenter.default.post(name: .addTopping, object: margheritaOrder, userInfo: ["extra": Topping("salami", isVeg: false)])
NotificationCenter.default.post(name: .addTopping, object: margheritaOrder, userInfo: ["extra": Topping("extra cheese", isVeg: true)])
NotificationCenter.default.post(name: .addTopping, object: margheritaOrder, userInfo: ["extra": Topping("pepperoni", isVeg: true)])

NotificationCenter.default.post(name: .didUpdateOrderStatus, object: margheritaOrder, userInfo: ["status": OrderStatus.processing])
NotificationCenter.default.post(name: .addTopping, object: margheritaOrder, userInfo: ["extra": Topping("extra cheese", isVeg: true)])
NotificationCenter.default.post(name: .didUpdateOrderStatus, object: margheritaOrder, userInfo: ["status": OrderStatus.delivered])

//: [<Previous](@previous)  [Home](Introduction)  [Next>](@next)
