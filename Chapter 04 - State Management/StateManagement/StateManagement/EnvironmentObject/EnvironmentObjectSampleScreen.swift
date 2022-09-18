//
//  EnvironmentObjectSampleScreen.swift
//  StateManagement
//
//  Created by Peter Friese on 15.02.21.
//

import SwiftUI

class UserProfile: ObservableObject {
  @Published var name: String
  @Published var favouriteProgrammingLanguage: String
  @Published var favouriteColor: Color
  
  init(name: String, favouriteProgrammingLanguage: String, favouriteColor: Color) {
    self.name = name
    self.favouriteProgrammingLanguage = favouriteProgrammingLanguage
    self.favouriteColor = favouriteColor
  }
}

struct EnvironmentObjectSampleScreen: View {
  @StateObject var profile = UserProfile(name: "Peter", favouriteProgrammingLanguage: "Swift", favouriteColor: .pink)
  @State var isSettingsShown = false
  
  var body: some View {
    VStack(alignment: .leading) {
      Introduction(Text("Inject an object into the environment using .environmentObject(), and retrieve it later using @EnvironmentObject."))
      Form {
        Section(header: Text("")) {
          Text("This is just some random data")
          Text("Let's assume this was the main screen of an app")
          Text("Tap the cog icon to go to the fake settings screen")
        }
      }
      HStack {
        Text("Signed in as \(profile.name)")
          .foregroundColor(Color(UIColor.systemBackground))
        Spacer()
      }
      .padding(30)
      .background(profile.favouriteColor)
    }
    .ignoresSafeArea(edges: .bottom)
    .navigationTitle("@EnvironmentObject")
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action:showSetting){
          Image(systemName: "gearshape")
        }
      }
    }
    .sheet(isPresented: $isSettingsShown) {
      NavigationStack {
        SettingsScreen()
      }
      .environmentObject(profile) // very important to put this here, NOT inside the NavigationStack! See https://developer.apple.com/forums/thread/653367
    }
  }
  
  func showSetting() {
    isSettingsShown.toggle()
  }
}

struct EnvironmentObjectSampleScreen_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      EnvironmentObjectSampleScreen()
    }
  }
}
