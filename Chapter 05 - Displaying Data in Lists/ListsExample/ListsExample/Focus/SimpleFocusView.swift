//
//  SimpleFocusView.swift
//  ListsExample
//
//  Created by Peter Friese on 05.11.21.
//

import SwiftUI

struct SimpleFocusView: View {
  @FocusState private var isFirstNameFocused: Bool
  @FocusState private var isLastNameFocused: Bool
  
  @State private var firstName = ""
  @State private var lastName = ""
  
  var body: some View {
    Form {
      TextField("First Name", text: $firstName)
        .focused($isFirstNameFocused)
      TextField("Last Name", text: $lastName)
        .focused($isLastNameFocused)
      
      Button("Save") {
        if firstName.isEmpty {
          isFirstNameFocused = true
        }
        else if lastName.isEmpty {
          isLastNameFocused = true
        }
        else {
          isFirstNameFocused = false
          isLastNameFocused = false
        }
      }
    }
  }
}

// MARK: - Demo infrastructure

struct SimpleFocusViewDemo: View {
  var body: some View {
    VStack(alignment: .leading) {
      Introduction(Text("Simple focus using `Bool`."))
      SimpleFocusView()
    }
    .navigationTitle("Focus using Bool")
  }
}

struct SimpleFocusView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      SimpleFocusViewDemo()
    }
  }
}


