//
//  SchedulerDemoView.swift
//  SwiftUICombineSchedulers
//
//  Created by Peter Friese on 07.05.22.
//

import SwiftUI
import Combine

struct Event: Identifiable, Equatable {
  var id = UUID()
  var tag: String
  var isOnMain: Bool
  var threadName: String
}

class SchedulerDemoViewModel: ObservableObject {
  @Published var events = [Event]()
  required init() {
  }
  
  func performWork() -> AnyPublisher<Bool, Never> {
    self.logEvent(tag: "performWork")
    return Deferred {
      Future { promise in
        self.logEvent(tag: "performWork.Future start")
        sleep(5)
        self.logEvent(tag: "performWork.Future finished")
        promise(.success(true))
      }
    }
    .eraseToAnyPublisher()
  }
  
  
  func logEvent(tag: String) {
    let event = Event(tag: tag, isOnMain: Thread.isMainThread, threadName: Thread.current.debugDescription)
    DispatchQueue.main.async {
      self.events.insert(event, at: 0)
    }
    Thread.printDebug(tag:tag)
  }
  
  func start() {
    print("Starting...")
  }
}

struct SchedulerDemoView<T: SchedulerDemoViewModel> : View {
  var title: String
  var introduction: String
  
  @StateObject var viewModel: SchedulerDemoViewModel
  
  init(_ title: String, introduction: String) {
    self.title = title
    self.introduction = introduction
    self._viewModel = StateObject(wrappedValue: T.init())
  }
  
  var body: some View {
    SampleScreen(title,
                 introduction: introduction) {
      Button("Start") {
        viewModel.start()
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

struct SchedulerDemoView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      SchedulerDemoView("Title", introduction: "What this screen is about.")
    }
  }
}
