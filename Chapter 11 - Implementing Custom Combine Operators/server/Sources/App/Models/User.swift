import Vapor

struct UserAvailable: Content {
  var isAvailable: Bool
  var userName: String?
}

