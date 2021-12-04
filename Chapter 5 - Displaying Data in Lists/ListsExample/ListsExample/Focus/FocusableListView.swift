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

class ReminderListViewModel: ObservableObject {
  @Published var reminders: [Reminder] = Reminder.samples
  
  @Published var focusedReminder: Focusable?
  var previousFocusedReminder: Focusable?
  
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    $focusedReminder
      .removeDuplicates()
      .compactMap { focusedReminder -> Int? in
        defer { self.previousFocusedReminder = focusedReminder }
        
        guard focusedReminder != nil else { return nil }
        guard case .row(let previousId) = self.previousFocusedReminder else { return nil }
        guard let previousIndex = self.reminders.firstIndex(where: { $0.id == previousId } ) else { return nil }
        guard self.reminders[previousIndex].title.isEmpty else { return nil }
        
        return previousIndex
      }
      .delay(for: 0.01, scheduler: RunLoop.main) // <-- this helps reduce the visual jank
      .sink { index in
        self.reminders.remove(at: index)
      }
      .store(in: &cancellables)
  }
  
  func createNewReminder() {
    let newReminder = Reminder(title: "")

    // if any row is focused, insert the new reminder after the focused row
    if case .row(let id) = focusedReminder {
      if let index = reminders.firstIndex(where: { $0.id == id } ) {
        
        // If the currently selected reminder is empty, unfocus it.
        // This will kick off the pipeline that removes empty reminders.
        let currentReminder = reminders[index]
        guard !currentReminder.title.isEmpty else {
          focusedReminder = Focusable.none
          return
        }
        
        reminders.insert(newReminder, at: index + 1)
      }
    }
    // no row focused: append at the end of the list
    else {
      reminders.append(newReminder)
    }
    
    // focus the new reminder
    focusedReminder = .row(id: newReminder.id)

  }
}

/// Used to manage focus in a `List` view
enum Focusable: Hashable {
  case none
  case row(id: String)
}

struct FocusableListView: View {
  @StateObject var viewModel = ReminderListViewModel()
  
  @FocusState
  var focusedReminder: Focusable?
  
  var body: some View {
    List {
      ForEach($viewModel.reminders) { $reminder in
        TextField("", text: $reminder.title)
          .focused($focusedReminder, equals: .row(id: reminder.id))
          .onSubmit {
            viewModel.createNewReminder()
          }
      }
    }
    .onChange(of: focusedReminder)  { viewModel.focusedReminder = $0 }
    .onChange(of: viewModel.focusedReminder) { focusedReminder = $0 }
    .toolbar {
      ToolbarItemGroup(placement: .bottomBar) {
        Button(action: { viewModel.createNewReminder() }) {
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


