//
//  HomeViewModel.swift
//  pokedex
//
//  Created by Hugo Branco on 21/12/22.
//

import Foundation

class HomeViewModel: ObservableObject {
  @Published var results: [PokemonCompactModel] = []

  @Published var error: Bool = false

  // Next page's url.
  var nextPage: String?

  // Pokemon quantity fetched per request
  let limit: Int = 50

  // current page for fetching data
  var page: Int = 0

  func search(query: String? = nil, loadMore: Bool = false) async -> Void {
    if !loadMore { page = 0 }

    do {
      try await Service.search(limit: limit, offset: limit * page) { results in
        DispatchQueue.main.async {
          switch results {
          case .success(let results):
            if loadMore { self.results += results } else { self.results = results }

            self.page += 1
            self.error = false

          case .failure:
            self.error = true
          }
        }
      }
    } catch {
      DispatchQueue.main.async { self.error = true }
    }
  }
}
