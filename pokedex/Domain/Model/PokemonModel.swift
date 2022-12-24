//
//  PokemonModel.swift
//  pokedex
//
//  Created by Hugo Branco on 21/12/22.
//

import Foundation
import SwiftUI

struct PokemonCompactModel: Identifiable, Codable {
  let id: Int
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
  case bug
  case dark
  case dragon
  case electric
  case fairy
  case fighting
  case fire
  case flying
  case ghost
  case grass
  case ground
  case ice
  case normal
  case poison
  case psychic
  case rock
  case steel
  case water
}

extension PokemonType {
  func getColor() -> Color {
    return Color("type-\(self)")
  }
}
