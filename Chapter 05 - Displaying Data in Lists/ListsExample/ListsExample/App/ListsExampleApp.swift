//
//  ListsExampleApp.swift
//  ListsExample
//
//  Created by Peter Friese on 30.06.21.
//

import SwiftUI

@main
struct ListsExampleApp: App {
  var body: some Scene {
    WindowGroup {
      MenuScreen()
        .accentColor(Color(UIColor.systemPink))
    }
  }
}
