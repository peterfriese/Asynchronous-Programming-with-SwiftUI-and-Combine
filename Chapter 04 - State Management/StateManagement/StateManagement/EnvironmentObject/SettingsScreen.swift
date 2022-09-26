//
//  SettingsScreen.swift
//  StateManagement
//
//  Created by Peter Friese on 15.02.21.
//

import SwiftUI

struct SettingsScreen: View {
  var body: some View {
    VStack(alignment: .leading) {
      Form {
        Section {
          NavigationLink(destination: UserProfileScreen()) {
            Text("User Profile")
          }
          Text("General")
          Text("Theme")
          Text("App Icon")
        }
        Section {
          Text("Notifications")
        }
        Section {
          Text("Help")
          Text("Feedback")
          Text("About")
        }
      }
    }
    .navigationTitle("Settings")
  }
}

struct SettingsScreen_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      SettingsScreen()
        .environmentObject(UserProfile(name: "Peter", favouriteProgrammingLanguage: "Swift", favouriteColor: .pink))
    }
  }
}
