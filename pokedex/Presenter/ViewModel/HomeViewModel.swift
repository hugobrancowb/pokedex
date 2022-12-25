//
//  HomeViewModel.swift
//  pokedex
//
//  Created by Hugo Branco on 21/12/22.
//

import Foundation

class HomeViewModel: ObservableObject {
  @Published var state: HomeState = HomeState.data([])

  private var results: [PokemonCompactModel] = []

  /// Next page's url.
  var nextPage: String?

  /// Pokemon quantity fetched per request
  let limit: Int = 50

  /// Current page for fetching data
  var page: Int = 0

  func search(query: String? = nil, loadMore: Bool = false) -> Void {
    if !loadMore {
      page = 0
      DispatchQueue.main.async { self.state = .loading }
    }

    Task.init {
      do {
        try await Service.search(limit: limit, offset: limit * page) { results in
          DispatchQueue.main.async {
            switch results {
            case .success(let results):
              if loadMore { self.results += results } else { self.results = results }

              self.page += 1
              self.state = .data(self.results)

            case .failure:
              self.state = .error
            }
          }
        }
      } catch {
        DispatchQueue.main.async {
          self.state = .error
        }
      }
    }
  }

  enum HomeState {
    case error
    case loading
    case data(_ data: [PokemonCompactModel])
  }
}
