//
//  ClosuresDemoView.swift
//  ViewModifiers
//
//  Created by Peter Friese on 27.06.22.
//

import SwiftUI

private class PersonViewModel: ObservableObject {
  @Published var firstName = ""
  @Published var lastName = ""

  func save() {
    print("Save to disk")
  }
}

struct ClosuresDemoView: View {
  @State var message = ""
  @State var dirty = false
  @StateObject private var viewModel = PersonViewModel()

  var body: some View {
    Form {
      Section("Buttons") {
        Label(message, systemImage: "quote.bubble")
        Button("Tap me", action: {
          self.message = "You tapped me!"
        })
        Button("Tap me") {
          self.message = "You tapped me!"
        }
        Button("Reset") {
          message = ""
        }
      }
      Section("\(self.dirty ? "* " : "")Input fields") {
        TextField("First name", text: $viewModel.firstName)
          .onChange(of: viewModel.firstName) { newValue in
            self.dirty = true
          }

        TextField("Placeholder 2", text: $viewModel.lastName)
          .onChange(of: viewModel.lastName) { newValue in
            self.dirty = true
          }
      }
      .onSubmit {
        viewModel.save()
      }
    }
  }
}

struct ClosuresDemoView_Previews: PreviewProvider {
  static var previews: some View {
    ClosuresDemoView()
  }
}
