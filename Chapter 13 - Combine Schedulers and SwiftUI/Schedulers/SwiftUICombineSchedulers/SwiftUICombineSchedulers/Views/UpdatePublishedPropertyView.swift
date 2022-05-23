//
//  UpdatePublishedPropertyView.swift
//  SwiftUICombineSchedulers
//
//  Created by Peter Friese on 14.05.22.
//

import SwiftUI
import Combine

class UpdatePublishedPropertyViewModel: ObservableObject {
  @Published var demo = false
  @Published var events = [Event]()
  
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    $demo
      .handleEvents { subscription in
        self.logEvent(tag: "handleEvents")
      } receiveOutput: { value in
        self.logEvent(tag: "receiveOutput")
      } receiveCompletion: { completion in
        self.logEvent(tag: "receiveCompletion")
      } receiveCancel: {
        self.logEvent(tag: "receiveCancel")
      } receiveRequest: { demand in
        self.logEvent(tag: "receiveRequest")
      }
      .sink { value in
        self.logEvent(tag: "sink")
        print("Value: \(value)")
      }
      .store(in: &cancellables)
  }
  
  func logEvent(tag: String) {
    let event = Event(tag: tag, isOnMain: Thread.isMainThread, threadName: Thread.current.debugDescription)
    DispatchQueue.main.async {
      self.events.insert(event, at: 0)
    }
    Thread.printDebug(tag:tag)
  }
}

struct UpdatePublishedPropertyView: View {
  @StateObject var viewModel = UpdatePublishedPropertyViewModel()
  
  var body: some View {
    SampleScreen("Default baheviour",
                 introduction: "Flip the switch and see which thread receives the event") {
      Toggle(isOn: $viewModel.demo) {
        Text("Flip the switch")
      }
      .padding()
      Button("Toggle from main thread") {
        viewModel.demo.toggle()
      }
      .buttonStyle(.action)
      Button("Toggle from background thread") {
        DispatchQueue.global().async {
          viewModel.demo.toggle()
        }
      }
      .buttonStyle(.action)
      
      List(viewModel.events) { event in
        HStack {
          VStack {
            Text("isMain")
              .font(.caption2)
            Image(systemName: event.isOnMain ? "checkmark.diamond" : "diamond")
          }
          Divider()
          VStack(alignment: .leading) {
            Text("[\(event.tag)]")
            Text(event.threadName)
              .font(.caption)
          }
        }
      }
      .animation(.default, value: viewModel.events)
    }
  }
  
}

struct UpdatePublishedPropertyView_Previews: PreviewProvider {
  static var previews: some View {
    UpdatePublishedPropertyView()
  }
}
