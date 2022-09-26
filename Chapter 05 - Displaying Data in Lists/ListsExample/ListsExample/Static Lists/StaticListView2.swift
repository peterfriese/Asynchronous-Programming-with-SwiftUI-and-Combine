//
//  StaticListView2.swift
//  ListsExample
//
//  Created by Peter Friese on 30.06.21.
//

import SwiftUI

struct StaticListView2: View {
  @State var number: Int = 42
  @State var degrees: Double = 37.5
  @State var toggle = true
  @State var name = "Peter"
  @State var secret = "s3cr3t!"
  
  var fruits = ["Apples", "Bananas", "Mangoes"]
  @State var fruit = "Mangoes"
  
  var body: some View {
    List {
      Text("Hello, world!")
      Label("The answer", systemImage: "42.circle")
      Slider(value: $degrees, in: 0...50) {
        Text("\(degrees)")
      } minimumValueLabel: {
        Text("min")
      } maximumValueLabel: {
        Text("max")
      }

      Stepper(value: $number, in: 0...100) {
        Text("\(number)")
      }
      Toggle(isOn: $toggle) {
        Text("Checked")
      }
      TextField("Name", text: $name)
      SecureField("Secret", text: $secret)
      ProgressView(value: 0.3)
      Picker(selection: $fruit, label: Text("Pick your favourite fruit")) {
        ForEach(fruits, id: \.self) { fruit in
          Text(fruit)
        }
      }
    }
  }
}

// MARK: - Demo infrastructure

struct StaticListView2Demo: View {
  var body: some View {
    VStack(alignment: .leading) {
      Introduction("In fact, you can place up to 10 views inside a List")
      StaticListView2()
    }
    .listStyle(.insetGrouped) // to get back the original look and feel
    .navigationTitle("List with multiple simple rows")
  }
}

struct StaticListView2Demo_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      StaticListView2Demo()
    }
  }
}
