//
//  FocusUsingEnumView.swift
//  ListsExample
//
//  Created by Peter Friese on 05.11.21.
//

import SwiftUI

enum FocusableField: Hashable {
  case firstName
  case lastName
}

struct FocusUsingEnumView: View {
  @FocusState private var focus: FocusableField?
  
  @State private var firstName = ""
  @State private var lastName = ""
  
  var body: some View {
    Form {
      TextField("First Name", text: $firstName)
        .focused($focus, equals: .firstName)
      TextField("Last Name", text: $lastName)
        .focused($focus, equals: .lastName)
      
      Button("Save") {
        if firstName.isEmpty {
          focus = .firstName
        }
        else if lastName.isEmpty {
          focus = .lastName
        }
        else {
          focus = nil
        }
      }
    }
  }
}

// MARK: - Demo infrastructure

struct FocusUsingEnumViewDemo: View {
  var body: some View {
    VStack(alignment: .leading) {
      Introduction(Text("Simple focus using `Bool`."))
      FocusUsingEnumView()
    }
    .navigationTitle("Focus using Bool")
  }
}

struct FocusUsingEnumView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      FocusableListViewDemo()
    }
  }
}


