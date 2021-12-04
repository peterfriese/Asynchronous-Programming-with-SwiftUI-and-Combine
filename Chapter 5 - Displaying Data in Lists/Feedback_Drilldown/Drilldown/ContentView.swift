//
//  ContentView.swift
//  Drilldown
//
//  Created by Peter Friese on 05.07.21.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      MenuView()
    }
    .navigationViewStyle(.stack)
  }
}

struct MenuView: View {
  var body: some View {
    List {
      NavigationLink(destination: LevelOneView()) {
        Text("Level ONE")
      }
      NavigationLink(destination: LevelTwoView()) {
        Text("Level TWO")
      }
    }
    .navigationTitle("Menu")
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: {}) {
          Image(systemName: "gear")
        }
      }
    }
  }
}


struct LevelOneView: View {
  
  var items = ["a", "b", "c", "d", "e", "f", "g"]
  
  var body: some View {
    List {
      ForEach(items, id:\.self) { item in
        NavigationLink(destination: LevelTwoView()) {
          Text(item)
        }
      }
    }
    .navigationTitle("Level One")
  }
}

struct LevelTwoView: View {
  var items = [
    "one", "two", "three", "four", "five", "six", "seven"
  ]
  
  var body: some View {
    List {
      ForEach(items, id:\.self) { item in
        NavigationLink(destination: LevelThreeView()) {
          Text(item)
        }
      }
    }
    .navigationTitle("Level Two")
    .toolbar {
      ToolbarItem(placement: .status) {
        Button(action: {}) {
          Text("Level TWO")
            .font(.caption)
        }
      }
      ToolbarItem(placement: .bottomBar) {
        Button(action: {}) {
          Image(systemName: "plus")
        }
      }
    }
  }
}

struct LevelThreeView: View {
  var items = ["1", "2", "3", "4", "5", "6", "7"]
  
  var body: some View {
    List(items, id:\.self) { item in
      NavigationLink(destination: LevelFourView()) {
        Text(item)
      }
    }
    .navigationTitle("Level Three")
    .toolbar {
      ToolbarItem(placement: .status) {
        Button(action: {}) {
          Text("Level THREE")
            .font(.caption)
        }
      }
      ToolbarItem(placement: .bottomBar) {
        Button(action: {}) {
          Image(systemName: "swift")
        }
      }
    }
  }
}

struct LevelFourView: View {
  var items = ["a", "b", "c", "d", "e", "f", "g"]
  
  var body: some View {
    List(items, id:\.self) { item in
      Text(item)
    }
    .navigationTitle("Level Three")
  }
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
