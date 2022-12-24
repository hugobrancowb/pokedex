//
//  HomeViewModel.swift
//  pokedex
//
//  Created by Hugo Branco on 21/12/22.
//

import Foundation

class HomeViewModel: ObservableObject {
  @Published var results: [PokemonSearchResult] = []

  @Published var error: Bool = false

  // Next page's url.
  var nextPage: String?

  let limit: Int = 50
  var page: Int = 0

  // TODO: add annotation only service function
  @MainActor func search(query: String? = nil, loadMore: Bool = false) async -> Void {
    if !loadMore { page = 0 }

    do {
      let results = try await Service.search(limit: limit, offset: limit * page)
      error = false

      if loadMore {
        self.results += results
      } else {
        self.results = results
      }

      page += 1
    } catch {
      self.error = true
    }
  }
}
