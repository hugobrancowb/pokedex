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
      let result = await searchDetails(name: pokemon.name)
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

    group.notify(queue: queue) {
      completion(.success(pokemonDetailList.sorted { a, b in a.id < b.id }))
    }
  }

  static private func searchDetails(name: String) async -> Result<PokemonCompactModel, ServiceError> {
    let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(name)")!

    guard let (data, _) = try? await URLSession.shared.data(from: url)
    else { return .failure(ServiceError.fetchingError) }

    do {
      let result = try JSONDecoder().decode(PokemonCompactModel.self, from: data)
      return .success(result)
    } catch {
      print(error)
      return .failure(ServiceError.decodingError)
    }
  }
}

enum ServiceError: Error {
  case fetchingError
  case decodingError
}
