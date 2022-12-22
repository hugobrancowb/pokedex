//
//  PokemonCompactModel.swift
//  pokedex
//
//  Created by Hugo Branco on 21/12/22.
//

import Foundation

struct PokemonSearchResultList: Codable {
  let count: Int
  let next: String?
  let previous: String?
  let results: [PokemonSearchResult]
}

struct PokemonSearchResult: Codable {
  let name: String
  let url: String
}
