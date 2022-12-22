//
//  HomeViewModel.swift
//  pokedex
//
//  Created by Hugo Branco on 21/12/22.
//

import Foundation

class HomeViewModel: ObservableObject {
  @Published var results: [PokemonSearchResult] = []

  // Next page's url.
  var nextPage: String?

  func search(query: String? = nil) {
    print("starting request")
    guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=50&offset=0") else { return }

    let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
      guard let data = data, error == nil else { return }

      do {
        let results = try JSONDecoder().decode(PokemonSearchResultList.self, from: data)

        DispatchQueue.main.async {
          self?.nextPage = results.next
          self?.results = results.results

          print("request finished")
        }
      }
      catch {
        print("erro na busca")
      }
    }

    task.resume()
  }
}
