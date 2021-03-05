import SwiftUI
import PlaygroundSupport

//struct Address {
//  let street: String
//  let postCode: String
//  let city: String
//  let country: String
//}
//
//let appleHQ = Address(street: "One Infinite Loop",
//                      postCode: "CA 95014",
//                      city: "Cupertino",
//                      country: "United States")
//
//
//struct ContentView: View {
//  var body: some View {
//    Text("Apple HQ: \(appleHQ.street)")
//  }
//}

// MARK: -

//struct ContentView: View {
//  @State var favouriteNumber: Int = 42
//
//  var body: some View {
//    VStack {
//      Text("Your favourite number is \(favouriteNumber)")
//      ChildView(number: $favouriteNumber)
//    }
//  }
//}
//
//struct ChildView: View {
//  @Binding var number: Int
//
//  var body: some View {
//    Stepper("\(number)", value: $number, in: 0...100)
//  }
//}

// MARK: -

//class Counter: ObservableObject {
//  @Published var count = 0
//}
//
//struct StateStepper: View {
//  @ObservedObject var stateCounter = Counter()
//  var body: some View {
//    Section(header: Text("@StateObject")) {
//      Stepper("Counter: \(stateCounter.count)", value: $stateCounter.count)
//    }
//  }
//}
//
//
//struct ContentView: View {
//
//  @State var color: Color = Color.accentColor
//
//  var body: some View {
//    VStack(alignment: .leading) {
//      StateStepper()
//      ColorPicker("Pick a color", selection: $color)
//    }
//    .foregroundColor(color)
//    .frame(width: 320, height: 640)
//  }
//}

class Counter: ObservableObject {
  @Published var count = 0
}

struct ObservedStepper: View {
  @ObservedObject var counter = Counter()
  var body: some View {
    Section(header: Text("@ObservedObject")) {
      Stepper("Counter: \(counter.count)", value: $counter.count)
    }
  }
}

struct ContentView: View {
  @State var color: Color = Color.accentColor
  
  var body: some View {
    VStack(alignment: .leading) {
      ObservedStepper()
      ColorPicker("Pick a color", selection: $color)
    }
    .foregroundColor(color)
  }
}

PlaygroundPage.current.setLiveView(ContentView().frame(width: 320, height: 640))
