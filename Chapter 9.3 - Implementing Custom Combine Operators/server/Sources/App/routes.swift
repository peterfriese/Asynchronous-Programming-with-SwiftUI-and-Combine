import Vapor

enum InternalServerError: Error {
  case databaseCorrupted
  case maintenance
}

extension InternalServerError: AbortError {
  var reason: String {
    switch self {
    case .databaseCorrupted:
      return "The database is corrupted"
    case .maintenance:
      return "Temporarily unavailable for maintenance"
    @unknown default:
      return "Some other internal server error"
    }
  }
  
  var status: HTTPStatus {
    return .internalServerError
  }
  
  var headers: HTTPHeaders {
    if case .maintenance = self {
      return ["Retry-After" : "17"]
    }
    else {
      return [:]
    }
  }
}

enum UsernameError: Error {
  case missing
  case emptyName
  case tooShort
  case illegalName(name: String)
}

extension UsernameError: AbortError {
  var reason: String {
    switch self {
    case .missing:
      return "Username parameter missing"
    case .emptyName:
      return "Username must not be empty"
    case .tooShort:
      return "Username is too short."
    case .illegalName(let name):
      return "Username is not valid: \(name)."
    }
  }
  
  var status: HTTPStatus {
    switch self {
    case .missing:
      return .badRequest
    case .emptyName:
      return .badRequest
    case .tooShort:
      return .badRequest
    case .illegalName(_):
      return .badRequest
    }
  }
}

var maintenanceCounter: Int = 0

func routes(_ app: Application) throws {
  app.get { req in
    return "It works!"
  }
  
  app.get("hello") { req -> String in
    return "Hello, world!"
  }
  
  app.get("isUserNameAvailable") { req -> UserAvailable in
    // validation: username must be present
    guard let userName: String = req.query["userName"] else {
      throw UsernameError.missing
    }
    print("Username: \(userName)")
    
    // validation: username must not be empty
    if userName.isEmpty {
      throw UsernameError.emptyName
    }
    
    // validation: names with fewer than 4 characters are fobidden
    if userName.count <= 3 {
      throw UsernameError.tooShort
    }
    
    // validation: filter illegal names
    if ["admin", "superuser"].contains(userName) {
      throw UsernameError.illegalName(name: userName)
    }
    
    // simulate a permanent internal server error: database corrupted
    if userName == "servererror" {
      throw InternalServerError.databaseCorrupted
    }
    
    // simulate a non-permanent internal server error: database corrupted
    if userName == "maintenance" {
      maintenanceCounter += 1
      print("Maintenance counter: \(maintenanceCounter)")
      if maintenanceCounter % 3 != 0 {
        print("... throwing maintenance error")
        throw InternalServerError.maintenance
      }
      else {
        print("... NOT throwing maintenance error")
      }
    }
    
    // simulate a non-permanent internal server error: database corrupted
    if userName == "maintenance!" {
      throw InternalServerError.maintenance
    }


    // simulate decoding error by sending a response that has fewer fields than the client expects
    if userName == "illegalresponse" {
      return UserAvailable(isAvailable: false)
    }
    
    // check if username is available and return result
    let isAvailable = !["peterfriese", "johnnyappleseed", "page", "johndoe"].contains(userName)
    return UserAvailable(isAvailable: isAvailable, userName: userName)
  }
  
}
