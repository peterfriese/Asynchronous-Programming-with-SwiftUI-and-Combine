import Foundation

public struct Topping {
  public var name: String
  public var isVegan: Bool

  public init(_ name: String, isVegan: Bool) {
    self.name = name
    self.isVegan = isVegan
  }
}

public enum OrderStatus: String {
  case placing
  case placed
  case processing
  case delivered
}

public enum AddressStatus: String {
  case invalid
  case valid
}

public extension Notification.Name {
  static let addTopping = Notification.Name(rawValue: "addTopping")
  static let didUpdateOrderStatus = Notification.Name(rawValue: "didUpdateOrderStatus")
  
  static let didValidateAddress = Notification.Name(rawValue: "didValidateAddress")
}

public class Order {
  public var status: OrderStatus {
    willSet {
      print("Status of order is now [\(newValue)]")
    }
  }
  public var toppings: [Topping]?
  public var addressStatus: AddressStatus
  
  public init() {
    self.status = .placing
    self.addressStatus = .invalid
  }
  
  public convenience init(toppings: [Topping]) {
    self.init()
    self.toppings = toppings
  }
}

