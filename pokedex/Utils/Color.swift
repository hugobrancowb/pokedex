//
//  Color.swift
//  pokedex
//
//  Created by Hugo Branco on 21/12/22.
//

import SwiftUI

extension Color {
  static let background = Color("background")
  static let darkGray = Color("dark-gray")
  static let lightGray = Color("light-gray")
  static let mediumGray = Color("medium-gray")
//  static let white = Color("white")
}

extension PokemonType {
  func getColor() -> Color {
    return Color("type-\(self)")
  }
}
