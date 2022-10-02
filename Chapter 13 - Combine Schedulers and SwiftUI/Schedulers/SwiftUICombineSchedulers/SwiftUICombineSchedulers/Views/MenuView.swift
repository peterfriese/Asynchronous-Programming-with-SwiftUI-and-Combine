//
//  MenuView.swift
//  SwiftUICombineSchedulers
//
//  Created by Peter Friese on 07.05.22.
//

import SwiftUI
import Combine

struct MenuView: View {
  var body: some View {
    Form {
      Section("Default behaviour") {
        NavigationLink("Update published property view") {
          UpdatePublishedPropertyView()
        }
      }
      
      Section("Launch on main thread") {
        NavigationLink("Start on main thread") {
          SchedulerDemoView<LaunchOnMainViewModel>("Main thread", introduction: "Launch on main thread")
        }
        NavigationLink("Start on main thread, subscribe on background") {
          SchedulerDemoView<LaunchOnMainSubscribeOnBackgroundViewModel>("Launch on main thread, subscribe on background", introduction: "Launch on main thread, subscribe on background thread")
        }
        NavigationLink("Start on main thread, subscribe on background, receive on main") {
          SchedulerDemoView<LaunchOnMainSubscribeOnBackgroundReceiveOnMainViewModel>("Launch on main thread, subscribe on background, receive on main", introduction: "Launch on main thread, subscribe on background thread, receive on main")
        }
      }

      Section("Launch on background thread") {
        NavigationLink("Start on background thread") {
          SchedulerDemoView<LaunchOnBackgroundViewModel>("Background thread", introduction: "Launch on background thread")
        }
        NavigationLink("Start on background thread, subscribe on background") {
          SchedulerDemoView<LaunchOnBackgroundSubscribeOnBackgroundViewModel>("Launch on background thread, subscribe on background", introduction: "Launch on background thread, subscribe on background thread")
        }
        NavigationLink("Start on background thread, subscribe on background, receive on main") {
          SchedulerDemoView<LaunchOnBackgroundSubscribeOnBackgroundReceiveOnMainViewModel>("Launch on background thread, subscribe on background, receive on main", introduction: "Launch on background thread, subscribe on background thread, receive on main")
        }
      }
      
      Section("Other operators") {
        NavigationLink("Debounce (on main thread)") {
          DebounceDemoView<DebounceMainViewModel>()
        }
        NavigationLink("Debounce (on background thread)") {
          DebounceDemoView<DebounceBackgroundViewModel>()
        }
      }
      
      Section("Async work") {
        NavigationLink("Async work") {
          SchedulerDemoView<AsyncWorkViewModel>("Async work", introduction: "Perform work on background thread, then update UI on main thread")
        }
      }
    }
    .navigationTitle("Combine Schedulers")
  }
}

struct MenuView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      MenuView()
    }
  }
}
