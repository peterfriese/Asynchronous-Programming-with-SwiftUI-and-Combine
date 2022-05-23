//
//  LaunchOnBackgroundViewModel.swift
//  SwiftUICombineSchedulers
//
//  Created by Peter Friese on 07.05.22.
//

import Foundation
import Combine

class LaunchOnBackgroundViewModel: SchedulerDemoViewModel {
  @Published var busy = false
  @Published var times = 0
  
  private var cancellables = Set<AnyCancellable>()

  override func start() {
    self.logEvent(tag: "start: at beginning")
    
    DispatchQueue.global(qos: .background).async {
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
}

class LaunchOnBackgroundSubscribeOnBackgroundViewModel: SchedulerDemoViewModel {
  @Published var busy = false
  @Published var times = 0
  
  private var cancellables = Set<AnyCancellable>()
  
  override func start() {
    self.logEvent(tag: "start: at beginning")
    
    DispatchQueue.global(qos: .background).async {
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
}

class LaunchOnBackgroundSubscribeOnBackgroundReceiveOnMainViewModel: SchedulerDemoViewModel {
  @Published var busy = false
  @Published var times = 0
  
  private var cancellables = Set<AnyCancellable>()
  
  override func start() {
    self.logEvent(tag: "start: at beginning")
    
    DispatchQueue.global(qos: .background).async {
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
        .receive(on: DispatchQueue.main)
        .sink { value in
          self.logEvent(tag: "sink")
          self.times = value
        }
        .store(in: &self.cancellables)
      
      self.logEvent(tag: "start: at end")
    }
  }
}

