//
//  EditableListView.swift
//  EditableListView
//
//  Created by Peter Friese on 23.08.21.
//

import SwiftUI

private class EditableBooksViewModel: ObservableObject {
  @Published var books: [Book] = Book.samples
}

struct EditableBooksListView: View {
  @StateObject fileprivate var viewModel = EditableBooksViewModel()
  @State var change: String?
  
  var body: some View {
    List($viewModel.books) { $book in
      EditableBookRowView(book: $book)
        .onChange(of: book.title) { title in
          print("You changed the title of the book to \(title)")
          change = title
        }
    }
    .toolbar {
      ToolbarItem(placement: .status) {
        if let change = change {
          Text("Change: \(change)")
        }
        else {
          Text("Change a book title to see the change here!")
            .foregroundColor(.accentColor)
        }
      }
    }
  }
}

private struct EditableBookRowView: View {
  @Binding var book: Book
  
  var body: some View {
    HStack(alignment: .top) {
      Image(book.mediumCoverImageName)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(height: 90)
      VStack(alignment: .leading) {
        TextField("Book title", text: $book.title, prompt: Text("Enter the book title"))
          .font(.headline)
        Text("by \(book.author)")
          .font(.subheadline)
        Text("\(book.pages) pages")
          .font(.subheadline)
      }
      Spacer()
    }
  }
}


// MARK: - Demo infrastructure

struct EditableBooksListViewDemo: View {
  var body: some View {
    VStack(alignment: .leading) {
      Introduction(Text("You can use bindings in `List` views to make the list items modifiable."))
      EditableBooksListView()
    }
    .listStyle(.insetGrouped) // to get back the original look and feel
    .navigationTitle("Editable list")
  }
}

struct EditableBooksListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      EditableBooksListViewDemo()
    }
  }
}
