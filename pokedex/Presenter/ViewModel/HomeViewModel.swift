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
  
  var offset: Int = 0
  
  var seasonOffset: Int = 0

  var selectedGen: Int = 0
  
  /// Changes filter for season list
  func onFilterChange(season: Int) -> Void {
    selectedGen = season

    switch season {
    case 1:
      seasonOffset = 0
    case 2:
      seasonOffset = 151
    case 3:
      seasonOffset = 251
    case 4:
      seasonOffset = 386
    case 5:
      seasonOffset = 494
    case 6:
      seasonOffset = 649
    case 7:
      seasonOffset = 721
    case 8:
      seasonOffset = 809
    case 9:
      seasonOffset = 905
    default:
      offset = 0
    }
    
    offset = seasonOffset
    search()
  }
  
  func search(query: String? = nil, loadMore: Bool = false) -> Void {
    if !loadMore {
      page = 0
      DispatchQueue.main.async { self.state = .loading }
    }
    
    Task.init {
      do {
        try await Service.search(limit: limit, offset: offset) { results in
          DispatchQueue.main.async {
            switch results {
            case .success(let results):
              if loadMore { self.results += results } else { self.results = results }
              
              self.page += 1
              self.state = .data(self.results)
              self.offset = self.seasonOffset + (self.limit * self.page)
              
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
