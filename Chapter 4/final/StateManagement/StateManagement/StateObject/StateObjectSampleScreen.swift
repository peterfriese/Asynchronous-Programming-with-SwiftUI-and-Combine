//
//  StateObjectSampleScreen.swift
//  StateManagement
//
//  Created by Peter Friese on 09.02.21.
//

import SwiftUI

class Counter: ObservableObject {
  @Published var count = 0
}

struct StateObjectSampleScreen: View {
  
  @State var color: Color = Color.accentColor
  
  var body: some View {
    VStack(alignment: .leading) {
      Introduction("References managed by @StateObject will be created just once. References managed by @ObservedObject will be re-created whenever SwiftUI re-creates the view. To see this in action, dial in a value on both counters, then use the color picker to force SwiftUI to re-create the parent view. The counter managed by @StateObject will keep its value, the one managed by @ObservedObject will reset to zero.")
      Form {
        StateStepper()
        ObservedStepper()
        Section(header: Text("Accent color")) {
          ColorPicker("Pick a color", selection: $color)
        }
      }
      .navigationTitle("@StateObject")
      .foregroundColor(color)
    }
  }
}

struct StateStepper: View {
  @StateObject var stateCounter = Counter()
  var body: some View {
    Section(header: Text("@StateObject")) {
      Stepper("Counter: \(stateCounter.count)", value: $stateCounter.count)
    }
  }
}

struct ObservedStepper: View {
  @ObservedObject var observedCounter = Counter()
  var body: some View {
    Section(header: Text("@ObservedObject")) {
      Stepper("Counter: \(observedCounter.count)", value: $observedCounter.count)
    }
  }
}

struct StateObjectSampleScreen_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      StateObjectSampleScreen()
    }
  }
}
