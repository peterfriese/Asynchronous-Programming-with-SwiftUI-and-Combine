//
//  MenuScreen.swift
//  WrappingExistingAPIsInCombine
//
//  Created by Peter Friese on 12.04.22.
//

import SwiftUI

struct MenuScreen: View {
  var body: some View {
    SampleScreen("Wrapping existing APIs in Combine",
                 introduction: "This sample shows how to wrap closure-based APIs in Combine.\n\n"
                  + "To run this demo, install the Firebase Emulator Suite and run the `start.sh` script in the root folder of this project.")
    {
      Form {
        Section(header: Text("Closure-based APIs")) {
          NavigationLink(destination: OnDemandBookDetailsViewWithClosures()) {
            Label("On-demand fetch a single book", systemImage: "book")
          }
          NavigationLink(destination: OnDemandBookListViewWithClosures()) {
            Label("On-demand fetch list of books", systemImage: "book")
          }
          NavigationLink(destination: LiveBooksListViewWithClosures()) {
            Label("Live books list", systemImage: "bolt")
          }
        }
        Section(header: Text("Combine-based APIs")) {
          NavigationLink(destination: OnDemandBookDetailsViewWithCombine()) {
            Label("On-demand fetch a single book", systemImage: "book")
          }
          NavigationLink(destination: OnDemandBookListViewWithCombine()) {
            Label("On-demand fetch list of books", systemImage: "book")
          }
          NavigationLink(destination: LiveBooksListViewWithCombine()) {
            Label("Live books list", systemImage: "bolt")
          }
        }
      }
    }
  }
}

struct MenuScreen_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      MenuScreen()
    }
  }
}
