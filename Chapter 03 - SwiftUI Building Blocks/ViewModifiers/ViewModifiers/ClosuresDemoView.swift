//
//  ClosuresDemoView.swift
//  ViewModifiers
//
//  Created by Peter Friese on 14.09.22.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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
      Section("\(self.dirty ? "* " : "")Input fields") {
        TextField("First name", text: $viewModel.firstName)
          .onChange(of: viewModel.firstName) { newValue in
            self.dirty = true
          }
        
        TextField("Last name", text: $viewModel.lastName)
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
