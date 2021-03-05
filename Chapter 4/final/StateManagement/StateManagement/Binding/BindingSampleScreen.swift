//
//  BindingSampleView.swift
//  StateManagement
//
//  Created by Peter Friese on 08.02.21.
//

import SwiftUI

struct BindingSampleScreen: View {
  @State var favouriteNumber: Int = 42
  
  var body: some View {
    VStack(alignment: .leading) {
      Introduction("This screen contains how an @State variable on a parent view can be modified in a child view (NumberEditView) by using @Binding. Any changes will be reflected in NumberView, which is also connected to the @State variable via @Binding.")
      Form {
        Section(header: Text("Favourite number")) {
          NumberEditView(number: $favouriteNumber)
        }
      }
      HStack {
        Spacer()
        NumberView(number: $favouriteNumber)
        Spacer()
      }
    }
    .navigationTitle("@Binding")
  }
}

struct NumberView: View {
  @Binding var number: Int
  
  var body: some View {
    Image(systemName: "\(number).circle")
      .resizable()
      .aspectRatio(contentMode: .fit)
      .foregroundColor(.accentColor)
      .padding(20)
  }
}

struct NumberEditView: View {
  @Binding var number: Int
  
  var body: some View {
    Stepper("\(number)", value: $number, in: 0...100)
  }
}

struct BindingSampleView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      BindingSampleScreen()
    }
  }
}
