//
//  LaunchOnMainViewModels.swift
//  SwiftUICombineSchedulers
//
//  Created by Peter Friese on 07.05.22.
//

import Foundation
import Combine

class LaunchOnMainViewModel: SchedulerDemoViewModel {
  @Published var busy = false
  @Published var times = 0
  
  private var cancellables = Set<AnyCancellable>()
  
  override func start() {
    self.logEvent(tag: "start: at beginning")
    
    self.performWork()
      .handleEvents(receiveSubscription: { sub in
        self.logEvent(tag: "receiveSubscription")
      }, receiveOutput: { value in
        self.logEvent(tag: "receiveOutput")
      }, receiveCompletion: { completion in
        self.logEvent(tag: "receiveCompletion")
      }, receiveCancel: {
        self.logEvent(tag: "receiveCancel")
      }, receiveRequest: { demand in
        self.logEvent(tag: "receiveRequest")
      })
      .map { value -> Bool in
        self.logEvent(tag: "map 1")
        return value
      }
    //      .subscribe(on: DispatchQueue.global(qos: .background))
      .eraseToAnyPublisher()
      .map { value -> Int in
        self.logEvent(tag: "map")
        return self.times + 1
      }
    //      .receive(on: DispatchQueue.main)
      .sink { value in
        self.logEvent(tag: "sink")
        self.times = value
      }
      .store(in: &self.cancellables)
    
    self.logEvent(tag: "start: at end")
  }
}

class LaunchOnMainSubscribeOnBackgroundViewModel: SchedulerDemoViewModel {
  @Published var busy = false
  @Published var times = 0
  
  private var cancellables = Set<AnyCancellable>()
  
  override func start() {
    self.logEvent(tag: "start: at beginning")
    
    self.performWork()
      .handleEvents(receiveSubscription: { sub in
        self.logEvent(tag: "receiveSubscription")
      }, receiveOutput: { value in
        self.logEvent(tag: "receiveOutput")
      }, receiveCompletion: { completion in
        self.logEvent(tag: "receiveCompletion")
      }, receiveCancel: {
        self.logEvent(tag: "receiveCancel")
      }, receiveRequest: { demand in
        self.logEvent(tag: "receiveRequest")
      })
      .map { value -> Bool in
        self.logEvent(tag: "map 1")
        return value
      }
      .subscribe(on: DispatchQueue.global(qos: .background))
      .eraseToAnyPublisher()
      .map { value -> Int in
        self.logEvent(tag: "map")
        return self.times + 1
      }
    //      .receive(on: DispatchQueue.main)
      .sink { value in
        self.logEvent(tag: "sink")
        self.times = value
      }
      .store(in: &self.cancellables)
    
    self.logEvent(tag: "start: at end")
  }
}

class LaunchOnMainSubscribeOnBackgroundReceiveOnMainViewModel: SchedulerDemoViewModel {
  @Published var busy = false
  @Published var times = 0
  
  private var cancellables = Set<AnyCancellable>()
  
  override func start() {
    self.logEvent(tag: "start: at beginning")
    
    self.performWork()
      .handleEvents(receiveSubscription: { sub in
        self.logEvent(tag: "receiveSubscription")
      }, receiveOutput: { value in
        self.logEvent(tag: "receiveOutput")
      }, receiveCompletion: { completion in
        self.logEvent(tag: "receiveCompletion")
      }, receiveCancel: {
        self.logEvent(tag: "receiveCancel")
      }, receiveRequest: { demand in
        self.logEvent(tag: "receiveRequest")
      })
      .map { value -> Bool in
        self.logEvent(tag: "map 1")
        return value
      }
      .subscribe(on: DispatchQueue.global(qos: .background))
      .map { value -> Int in
        self.logEvent(tag: "map")
        return self.times + 1
      }
      .receive(on: DispatchQueue.main)
      .sink { value in
        self.logEvent(tag: "sink")
        self.times = value
      }
      .store(in: &self.cancellables)
    
    self.logEvent(tag: "start: at end")
  }
}

class AsyncWorkViewModel: SchedulerDemoViewModel {
  @Published var busy = false
  @Published var times = 0
  
  private var cancellables = Set<AnyCancellable>()
  
  override func start() {
    self.logEvent(tag: "start: at beginning")
    
    performWork()
      .handleEvents(receiveSubscription: { sub in
        self.logEvent(tag: "receiveSubscription")
      }, receiveOutput: { value in
        self.logEvent(tag: "receiveOutput")
      }, receiveCompletion: { completion in
        self.logEvent(tag: "receiveCompletion")
      }, receiveCancel: {
        self.logEvent(tag: "receiveCancel")
      }, receiveRequest: { demand in
        self.logEvent(tag: "receiveRequest")
      })
      .map { _ in
        self.logEvent(tag: "map 1")
      }
      .subscribe(on: DispatchQueue.global())
      .map { _ in
        self.logEvent(tag: "map 2")
      }
      .receive(on: DispatchQueue.main)
      .map { _ in
        self.logEvent(tag: "map 3")
      }
      .receive(on: DispatchQueue.global())
      .map { _ in
        self.logEvent(tag: "map 4")
      }
      .receive(on: DispatchQueue.main)
      .sink { _ in
        self.logEvent(tag: "sink")
      }
      .store(in: &self.cancellables)
    
    self.logEvent(tag: "start: at end")
  }
}
