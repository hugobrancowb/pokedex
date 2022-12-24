//
//  PokemonModel.swift
//  pokedex
//
//  Created by Hugo Branco on 21/12/22.
//

import Foundation

struct PokemonCompactModel: Identifiable, Decodable {
  let id: Int
  let name: String
  let sprites: SpriteModel
  let types: [PokemonTypeModel]
}

struct SpriteModel: Decodable {
  let front_default: String
  let back_default: String
  let other: OtherSprites

  var official: String { other.officialArtwork.frontDefault }


  struct OtherSprites: Decodable {
    let officialArtwork: OfficialArtwork

    enum CodingKeys: String, CodingKey {
      case officialArtwork = "official-artwork"
    }

    struct OfficialArtwork: Decodable {
      let frontDefault: String

      enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
      }
    }
  }
}

struct PokemonTypeModel: Decodable {
  let slot: Int
  let type: PokemonTypeDetails

  struct PokemonTypeDetails: Decodable {
    let name: PokemonType
    let url: String
  }
}

enum PokemonType: String, Decodable {
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
