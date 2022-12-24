//
//  Service.swift
//  pokedex
//
//  Created by Hugo Branco on 23/12/22.
//

import Foundation

class Service {
  static func search(limit: Int, offset: Int) async throws -> [PokemonSearchResult] {
    let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)")!

    let (data, response) = try await URLSession.shared.data(from: url)

    guard (response as? HTTPURLResponse)?.statusCode == 200
    else { throw ServiceError.fetchingError }

    guard let results = try? JSONDecoder().decode(PokemonSearchResultList.self, from: data)
    else { throw ServiceError.decodingError }

    return results.results
  }
}

private enum ServiceError: Error {
  case fetchingError
  case decodingError
}
