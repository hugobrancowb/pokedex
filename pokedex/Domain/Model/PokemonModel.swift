//
//  PokemonModel.swift
//  pokedex
//
//  Created by Hugo Branco on 21/12/22.
//

import Foundation

struct PokemonCompactModel: Identifiable, Codable {
  let id: String
  let name: String
  let sprites: SpriteModel
  let types: [PokemonTypeModel]
}

struct SpriteModel: Codable {
  let front_default: String
  let back_default: String
}

struct PokemonTypeModel: Codable {
  let slot: Int
  let type: PokemonTypeDetails

  struct PokemonTypeDetails: Codable {
    let name: PokemonType
    let url: String
  }
}

enum PokemonType: String, Codable {
  case grass = "grass"
  case fire = "fire"
  case water = "water"
}
