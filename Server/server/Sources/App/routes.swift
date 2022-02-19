import Vapor

func routes(_ app: Application) throws {
  app.get { req in
    return "It works!"
  }

  app.get("hello") { req -> String in
    return "Hello, world!"
  }

  app.get("isUserNameAvailable") { req -> UserAvailable in
    let userName: String = req.query["userName"] ?? "unknown"
    let isAvailable = !["peterfriese", "johnnyappleseed", "page", "johndoe"].contains(userName)
    return UserAvailable(isAvailable: isAvailable, userName: userName )
  }
}
