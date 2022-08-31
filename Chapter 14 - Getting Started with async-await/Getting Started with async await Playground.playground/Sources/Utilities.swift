import Foundation

public func customerSays(_ message: String) {
  print("[Customer] \(message)")
}

public func sandwichMakerSays(_ message: String, waitFor time: UInt32 = 0) {
  print("[Sandwich maker] \(message)")
  if time > 0 {
    print("                 ... this will take \(time)s")
    sleep(time)
  }
}
