//
//  Thread.swift
//  SwiftUICombineSchedulers
//
//  Created by Peter Friese on 14.05.22.
//

import Foundation

extension Thread {
  static func printDebug() {
    print("isMainThread: \(Thread.isMainThread) | \(Thread.current)")
  }
  
  static func printDebug(tag: String) {
    print("[\(tag)] isMainThread: \(Thread.isMainThread) | \(Thread.current)")
  }

}
