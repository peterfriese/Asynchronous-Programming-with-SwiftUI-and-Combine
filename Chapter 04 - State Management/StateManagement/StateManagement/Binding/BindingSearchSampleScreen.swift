//
//  BindingSearchSampleScreen.swift
//  StateManagement
//
//  Created by Peter Friese on 08.02.21.
//

import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
  @Published var query: String = ""
  @Published var  cities = [String]()
  let allCities = [
    "Hamburg",
    "London",
    "San Francisco",
    "New York",
    "Boulder",
    "Sydney"
  ]
  
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    $query.map { term in
      term.isEmpty
        ? self.allCities
        : self.allCities.filter { city in city.contains(term) }
    }
    .assign(to: \.cities, on: self)
    .store(in: &cancellables)
  }
}

struct BindingSearchSampleScreen: View {
  @StateObject var viewModel = SearchViewModel()
  
  var body: some View {
    VStack(alignment: .leading) {
      Introduction("@Binding can be used to connect a view on a child view to an @Published attribute on an @ObservableObject owned by the parent view. This is useful for search views.")
      
      TextField("Enter search term", text: $viewModel.query)
        .autocapitalization(.none)
        .padding(7)
        .background(Color(.systemGray5))
        .cornerRadius(8)
        .padding(.horizontal, 20)
      List(viewModel.cities, id: \.self) { city in
        Text(city)
      }
    }
    .navigationTitle("@Binding w/ ObservableObject")
  }
}

struct BindingSearchSampleScreen_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      BindingSearchSampleScreen()
    }
  }
}
