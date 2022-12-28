//
//  PokemonDetailViewModel.swift
//  pokedex
//
//  Created by Hugo Branco on 25/12/22.
//

import Foundation
import SwiftUI

class PokemonDetailViewModel: ObservableObject {
  
  init(_ pokemon: PokemonCompactModel) {
    self.pokemon = pokemon
    
    self.name = pokemon.name.capitalized
    self.imageUrl = pokemon.sprites.official
    self.weight = (CGFloat(pokemon.weight) / 10).description
    self.height = (CGFloat(pokemon.height) / 10).description
    self.types = pokemon.types.prefix(2).map { type in type.type.name }
    self.typeColor = pokemon.types.first?.type.name.getColor() ?? Color.gray
    
    self.hp = pokemon.stats.first(where: { $0.name == "hp" })?.baseStat ?? 0
    self.atk = pokemon.stats.first(where: { $0.name == "attack" })?.baseStat ?? 0
    self.def = pokemon.stats.first(where: { $0.name == "defense" })?.baseStat ?? 0
    self.satk = pokemon.stats.first(where: { $0.name == "special-attack" })?.baseStat ?? 0
    self.sdef = pokemon.stats.first(where: { $0.name == "special-defense" })?.baseStat ?? 0
    self.spd = pokemon.stats.first(where: { $0.name == "speed" })?.baseStat ?? 0
  }
  
  /// Pokemon model information
  private let pokemon: PokemonCompactModel
  
  /// Pokemon name
  let name: String
  
  let imageUrl: String
  
  /// Pokemon weight in kilograms
  let weight: String
  
  /// Pokemon height in meters
  let height: String
  
  /// Text description for Pokemon
  @Published var description: String?
  
  /// Types of the Pokemon
  let types: [PokemonType]
  
  /// Color for pokemon type
  let typeColor: Color
  
  let hp: Int
  let atk: Int
  let def: Int
  let satk: Int
  let sdef: Int
  let spd: Int
}
