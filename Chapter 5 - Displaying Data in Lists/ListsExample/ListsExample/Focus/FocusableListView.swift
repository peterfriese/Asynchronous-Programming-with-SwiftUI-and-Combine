//
//  FocusableListView.swift
//  ListsExample
//
//  Created by Peter Friese on 05.11.21.
//

import SwiftUI
import Combine

struct Reminder: Identifiable {
  var id: String = UUID().uuidString
  var title: String
}

extension Reminder {
  static var samples = [
    Reminder(title: "Build sample app"),
    Reminder(title: "Write blog post"),
    Reminder(title: "???"),
    Reminder(title: "PROFIT")
  ]
}

/// Used to manage focus in a `List` view
enum Focusable: Hashable {
  case none
  case row(id: String)
}

struct FocusableListView: View {
  @State var reminders: [Reminder] = Reminder.samples
  
  @FocusState var focusedTask: Focusable?
  var cancellables = Set<AnyCancellable>()
  
  var body: some View {
    List {
      ForEach($reminders) { $reminder in
        TextField("", text: $reminder.title)
          .focused($focusedTask, equals: .row(id: reminder.id))
          .onSubmit {
            createNewTask()
          }
      }
    }
    .toolbar {
      ToolbarItemGroup(placement: .bottomBar) {
        Button(action: { createNewTask() }) {
          HStack {
            Image(systemName: "plus.circle.fill")
            Text("New Reminder")
          }
        }
        .accentColor(Color(UIColor.systemRed))
        // needed to push the button to the left
        Spacer()
      }
    }
  }
  
  func createNewTask() {
    let newReminder = Reminder(title: "")
    reminders.append(newReminder)
    focusedTask = .row(id: newReminder.id)
  }
}

// MARK: - Demo infrastructure

struct FocusableListViewDemo: View {
  var body: some View {
    VStack(alignment: .leading) {
      Introduction(Text("You can use `@FocusState` to manage focus in SwiftUI. To focus elements in a list, you will need to implement an enum that has a single case with an associated value that contains the `id` of the respective row's element."))
      FocusableListView()
        .listStyle(.plain)
    }
    .navigationTitle("Focusable List Rows")
  }
}

struct FocusableListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      FocusableListViewDemo()
    }
  }
}


