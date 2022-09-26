//
//  PropertySampleScreen.swift
//  StateManagement
//
//  Created by Peter Friese on 07.02.21.
//

import SwiftUI

struct PropertySampleItem {
  var title: String
  var amount: Int
  var awake: Bool
}

extension PropertySampleItem {
  static let sample = PropertySampleItem(title: "Bar", amount: 21, awake: false)
}

struct PropertySampleScreen: View {
  var sampleItem = PropertySampleItem.sample
  
  var title = "Foo"
  var amount = 42
  var awake = true
  
  var body: some View {
    VStack(alignment: .leading) {
      Introduction("SwiftUI views can read values from simple or structured properties.")
      
      Form {
        Section(header: Text("Simple properties")) {
          Text("\(title)")
          Text("\(amount)")
          Toggle("Awake", isOn: .constant(awake))
        }
        Section(header: Text("Value type properties")) {
          Text("\(sampleItem.title)")
          Text("\(sampleItem.amount)")
          Toggle("Awake", isOn: .constant(sampleItem.awake))
        }
      }
    }
    .navigationTitle("Property")
  }
}

struct PropertySampleScreen_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      PropertySampleScreen()
    }
  }
}
