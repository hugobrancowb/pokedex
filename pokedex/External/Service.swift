//
//  Service.swift
//  pokedex
//
//  Created by Hugo Branco on 23/12/22.
//

import Foundation

class Service {
  static func search(limit: Int, offset: Int, _ completion: @escaping (Result<[PokemonCompactModel], ServiceError>) -> Void) async throws -> Void {
    let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)")!
    let (data, response) = try await URLSession.shared.data(from: url)

    guard (response as? HTTPURLResponse)?.statusCode == 200
    else { throw ServiceError.fetchingError }

    guard let results = try? JSONDecoder().decode(PokemonSearchResultList.self, from: data)
    else { throw ServiceError.decodingError }

    var pokemonDetailList: [PokemonCompactModel] = []
    let queue = DispatchQueue(label: "com.pokedex.search-details", attributes: .concurrent)
    let group = DispatchGroup.init()

    group.enter()
    for pokemon in results.results {
      searchDetails(name: pokemon.name) { result in
        switch result {
        case .success(let pokemon):
          pokemonDetailList.append(pokemon)
          if pokemonDetailList.count == results.results.count { group.leave() }
        case .failure(let error):
          print(error)
          completion(.failure(error))
          group.leave()
        }
      }
    }

    group.notify(queue: queue) {
      completion(.success(pokemonDetailList.sorted { a, b in a.id < b.id }))
    }
  }

  static private func searchDetails(name: String, _ handler: @escaping (Result<PokemonCompactModel, ServiceError>) -> Void) -> Void {
    let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(name)")!
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data, error == nil else { return }

      do {
        let result = try JSONDecoder().decode(PokemonCompactModel.self, from: data)
        handler(.success(result))
      }
      catch {
        print(error)
        handler(.failure(ServiceError.decodingError))
        return
      }
    }

    task.resume()
  }
}

enum ServiceError: Error {
  case fetchingError
  case decodingError
}
