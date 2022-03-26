//
//  StateSampleScreen.swift
//  StateManagement
//
//  Created by Peter Friese on 07.02.21.
//

import SwiftUI

struct StateSampleScreen: View {
  @State var sampleItem = PropertySampleItem.sample
  
  @State var title = "Foo"
  @State var amount = 42
  @State var awake = true
  
  @State var isSheetDisplayed = false
  
  var body: some View {
    VStack(alignment: .leading) {
      Introduction("The @State property wrapper is commonly used to drive local UI state. This screen demonstrates how to show an overlay sheet, or how to edit local properties that are marked as @State.")
      
      Form {
        Section(header: Text("Driving UI elements")) {
          Toggle("Is sheet displayed", isOn: $isSheetDisplayed)
          Text("Is sheet displayed: \(isSheetDisplayed ? "true" : "false")")
          Button(action: {isSheetDisplayed.toggle()}) {
            Text("Tap top open sheet")
          }
          .sheet(isPresented: $isSheetDisplayed) {
            Color.accentColor
              .overlay(
                VStack {
                  Text("Hello!")
                    .font(.title)
                    .padding()
                  Text("(Drag down to dismiss sheet)")
                    .font(.callout)
                }
                .foregroundColor(Color(UIColor.secondarySystemBackground))
              )
              .ignoresSafeArea()
          }
        }
        Section(header: Text("@State Value type properties (editable)")) {
          TextField("Title", text: $title)
          TextField("Amount:", value: $amount, formatter: NumberFormatter())
          Toggle("Awake", isOn: $awake)
        }
        Section(header: Text("Simple @State properties")) {
          Text("\(title)")
          Text("\(amount)")
          Toggle("Awake", isOn: $awake)
        }
        Section(header: Text("@State Value type properties (editable)")) {
          TextField("Title", text: $sampleItem.title)
          TextField("Amount:", value: $sampleItem.amount, formatter: NumberFormatter())
          Toggle("Awake", isOn: $sampleItem.awake)
        }
        Section(header: Text("@State Value type properties ")) {
          Text("\(sampleItem.title)")
          Text("\(sampleItem.amount)")
          Toggle("Awake", isOn: $sampleItem.awake)
        }
      }
    }
    .navigationTitle("@State")
  }
  
}

struct StateSampleScreen_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      StateSampleScreen()
    }
  }
}
