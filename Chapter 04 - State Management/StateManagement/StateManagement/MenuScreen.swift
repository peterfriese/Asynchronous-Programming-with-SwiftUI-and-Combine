//
//  ContentView.swift
//  StateManagement
//
//  Created by Peter Friese on 07.02.21.
//

import SwiftUI

struct MenuScreen: View {
  var body: some View {
    NavigationSplitView {
      List {
        Section(header: Text("Value Types")) {
          NavigationLink(destination: PropertySampleScreen()) {
            Label("Property", systemImage: "1.square")
          }
          NavigationLink(destination: StateSampleScreen()) {
            Label("@State", systemImage: "2.square")
          }
          NavigationLink(destination: BindingSampleScreen()) {
            Label("@Binding", systemImage: "3.square")
          }
          NavigationLink(destination: BindingSearchSampleScreen()) {
            Label("@Binding & ObservableObject", systemImage: "4.square")
          }
        }
        Section(header: Text("Reference Types")) {
          NavigationLink(destination: StateObjectSampleScreen()) {
            Label("@StateObject", systemImage: "5.square")
          }
          NavigationLink(destination: ObservedObjectSampleScreen(viewModel: BooksListViewModel(books: Book.samples))) {
            Label("@ObservedObject", systemImage: "6.square")
          }
          NavigationLink(destination: EnvironmentObjectSampleScreen()) {
            Label("@EnvironmentObject", systemImage: "7.square")
          }
        }
      }
      .listStyle(InsetGroupedListStyle())
      .navigationTitle("State Management")
    } detail: {
      Text("Please select a sample from the menu on the left")
    }

  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      MenuScreen()
    }
  }
}
