//
//  PokemonCompactModel.swift
//  pokedex
//
//  Created by Hugo Branco on 21/12/22.
//

import Foundation

struct PokemonSearchResultList: Decodable {
  let count: Int
  let next: String?
  let previous: String?
  let results: [PokemonSearchResult]
}

struct PokemonSearchResult: Equatable, Decodable {
  let name: String
  let url: String
}
