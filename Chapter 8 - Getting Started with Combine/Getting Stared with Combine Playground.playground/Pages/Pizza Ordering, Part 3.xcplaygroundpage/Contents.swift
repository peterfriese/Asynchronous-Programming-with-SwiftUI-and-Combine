//: [<Previous](@previous)  [Home](Introduction)  [Next>](@next)

import Foundation
import Combine

let margheritaOrder = Order(toppings: [
  Topping("tomatoes", isVegan: true),
  Topping("vegan mozzarella", isVegan: true),
  Topping("basil", isVegan: true)
])

let orderStatusPublisher = NotificationCenter.default.publisher(for: .didUpdateOrderStatus, object: margheritaOrder)
  .compactMap { notification in
    notification.userInfo?["status"] as? OrderStatus
  }
  .eraseToAnyPublisher()

let shippingAddressValidPublisher = NotificationCenter.default.publisher(for: .didValidateAddress, object: margheritaOrder)
  .compactMap { notification in
    notification.userInfo?["addressStatus"] as? AddressStatus
  }
  .eraseToAnyPublisher()

let readyToProducePublisher = Publishers.CombineLatest(orderStatusPublisher, shippingAddressValidPublisher)
readyToProducePublisher
  .print()
  .map { (orderStatus, addressStatus) in
    orderStatus == .placed && addressStatus == .valid
  }
  .sink {
    print("Ready to ship order: \($0)")
  }

NotificationCenter.default.post(name: .didValidateAddress, object: margheritaOrder, userInfo: ["addressStatus": AddressStatus.invalid])
NotificationCenter.default.post(name: .didUpdateOrderStatus, object: margheritaOrder, userInfo: ["status": OrderStatus.placed])
NotificationCenter.default.post(name: .didValidateAddress, object: margheritaOrder, userInfo: ["addressStatus": AddressStatus.valid])

//: [<Previous](@previous)  [Home](Introduction)  [Next>](@next)
