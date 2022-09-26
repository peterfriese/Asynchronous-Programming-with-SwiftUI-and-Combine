//
//  MenuScreen.swift
//  ListsExample
//
//  Created by Peter Friese on 01.07.21.
//

import SwiftUI

struct MenuScreen: View {
  var body: some View {
    NavigationSplitView {
      List() {
        Section(header: Text("Static Lists")) {
          NavigationLink(destination: StaticListViewDemo()) {
            Label("Static list with simple row", systemImage: "1.square")
          }
          NavigationLink(destination: StaticListView2Demo()) {
            Label("Static list with multiple simple rows", systemImage: "rectangle.grid.1x2")
          }
          NavigationLink(destination: StaticListWithSimpleCustomRowViewDemo()) {
            Label("Static list with custom row", systemImage: "3.square")
          }
          NavigationLink(destination: StaticListWithCustomRowViewDemo()) {
            Label("Static list with extracted row", systemImage: "4.square")
          }
        }
        Section(header: Text("Dynamic Lists")) {
          NavigationLink(destination: BooksListViewDemo()) {
            Label("Books List View", systemImage: "books.vertical")
          }
          NavigationLink(destination: AsyncFetchBooksListViewDemo()) {
            Label("Fetch data asynchronously", systemImage: "arrow.triangle.merge")
          }
          NavigationLink(destination: EditableBooksListViewDemo()) {
            Label("Editable Books List View", systemImage: "rectangle.and.pencil.and.ellipsis")
          }
          NavigationLink(destination: SearchableBooksListViewDemo()) {
            Label("Searchable Books List View", systemImage: "doc.text.magnifyingglass")
          }
          NavigationLink(destination: RefreshableBooksListViewDemo()) {
            Label("Refreshable Books List View", systemImage: "arrow.clockwise")
          }
        }
        Section(header: Text("Styling")) {
          DisclosureGroup {
            NavigationLink(destination: AutomaticStyleListViewDemo()) {
              Label("Style: `.automatic`", systemImage: "1.square")
            }
            NavigationLink(destination: GroupedStyleListViewDemo()) {
              Label("Style: `.grouped`", systemImage: "2.square")
            }
            NavigationLink(destination: InsetStyleListViewDemo()) {
              Label("Style: `.inset`", systemImage: "3.square")
            }
            NavigationLink(destination: InsetGroupedStyleListViewDemo()) {
              Label("Style: `.insetGrouped`", systemImage: "4.square")
            }
            NavigationLink(destination: PlainStyleListViewDemo()) {
              Label("Style: `.plain`", systemImage: "5.square")
            }
            NavigationLink(destination: SidebarStyleListViewDemo()) {
              Label("Style: `.sidebar`", systemImage: "6.square")
            }
          } label: {
            Label("List Styles", systemImage: "list.bullet.rectangle.portrait")
          }

          NavigationLink(destination: BasicListForStylingDemo()) {
            Label("List Styles", systemImage: "9.square")
          }
          NavigationLink(destination: StyleAccentColorDemo()) {
            Label("Accent Color", systemImage: "paintpalette")
          }
          
          DisclosureGroup {
            NavigationLink(destination: ListRowSeparatorStylingListViewDemo()) {
              Label("List Row Separators", systemImage: "rectangle.grid.1x2")
            }
            NavigationLink(destination: ListSectionSeparatorStylingListViewDemo()) {
              Label("List Section Separators", systemImage: "rectangle")
            }
          } label: {
            Label("Separators", systemImage: "line.3.horizontal")
          }
        }
        Section(header: Text("Grouping & Nesting")) {
          NavigationLink(destination: StickyHeaderListViewDemo()) {
            Label("Static list with sticky headers", systemImage: "1.square")
          }
        }
        Section(header: Text("Actions")) {
          NavigationLink(destination: SwipeToDeleteListViewDemo()) {
            Label("Swipe to delete / edit", systemImage: "1.square")
          }
          NavigationLink(destination: SwipeActionsListViewDemo()) {
            Label("Swipe Actions", systemImage: "2.square")
          }
        }
        Section(header: Text("Focus")) {
          NavigationLink(destination: SimpleFocusViewDemo()) {
            Label("Focus using Bool", systemImage: "1.square")
          }
          NavigationLink(destination: FocusUsingEnumViewDemo()) {
            Label("Focus using an Enum", systemImage: "2.square")
          }
          NavigationLink(destination: FocusableListViewDemo()) {
            Label("Focusable List Rows", systemImage: "3.square")
          }
        }

      }
      .listStyle(.insetGrouped)
      .navigationTitle("SwiftUI Lists")
    } detail: {
      Text("Select an item from the menu.")
    }
  }
}

struct MenuScreen_Previews: PreviewProvider {
  static var previews: some View {
    MenuScreen()
  }
}
