//
//  DebounceDemoView.swift
//  SwiftUICombineSchedulers
//
//  Created by Peter Friese on 15.05.22.
//

import SwiftUI
import Combine

class DebounceBaseViewModel: ObservableObject {
  @Published var input = ""
  @Published var output = ""
  
  @Published var events = [Event]()
  
  fileprivate var cancellables = Set<AnyCancellable>()
  
  required init() {
  }
  
  func logEvent(tag: String) {
    let event = Event(tag: tag, isOnMain: Thread.isMainThread, threadName: Thread.current.debugDescription)
    DispatchQueue.main.async {
      self.events.insert(event, at: 0)
    }
    Thread.printDebug(tag:tag)
  }
}

class DebounceMainViewModel: DebounceBaseViewModel {
  required init() {
    super.init()
    $input
      .debounce(for: 0.8, scheduler: DispatchQueue.main)
      .handleEvents { subscription in
        self.logEvent(tag: "handleEvents")
      } receiveOutput: { value in
        self.logEvent(tag: "receiveOutput - {\(value)}")
      } receiveCompletion: { completion in
        self.logEvent(tag: "receiveCompletion")
      } receiveCancel: {
        self.logEvent(tag: "receiveCancel")
      } receiveRequest: { demand in
        self.logEvent(tag: "receiveRequest")
      }
      .sink { value in
        self.logEvent(tag: "sink - {\(value)}")
        print("Value: \(value)")
        self.output = value
      }
      .store(in: &cancellables)
  }
}

class DebounceBackgroundViewModel: DebounceBaseViewModel {
  required init() {
    super.init()
    $input
      .debounce(for: 0.8, scheduler: DispatchQueue.global(qos: .background))
      .handleEvents { subscription in
        self.logEvent(tag: "handleEvents")
      } receiveOutput: { value in
        self.logEvent(tag: "receiveOutput - {\(value)}")
      } receiveCompletion: { completion in
        self.logEvent(tag: "receiveCompletion")
      } receiveCancel: {
        self.logEvent(tag: "receiveCancel")
      } receiveRequest: { demand in
        self.logEvent(tag: "receiveRequest")
      }
      .sink { value in
        self.logEvent(tag: "sink - {\(value)}")
        print("Value: \(value)")
        self.output = value
      }
      .store(in: &cancellables)
    
  }
}


struct DebounceDemoView<T: DebounceBaseViewModel>: View {
  @StateObject var viewModel: DebounceBaseViewModel
  
  init() {
    self._viewModel = StateObject(wrappedValue: T.init())
  }
  var body: some View {
    SampleScreen("Debounce Demo", introduction: "How to schedule the debounce operator") {
      Form {
        TextField("Enter some text", text: $viewModel.input)
        Text("You entered [\(viewModel.output)].")
      }
      .frame(maxHeight: 150)
      
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

struct DebounceDemoView_Previews: PreviewProvider {
  static var previews: some View {
    DebounceDemoView()
  }
}
