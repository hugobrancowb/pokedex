//
//  TypePill.swift
//  pokedex
//
//  Created by Hugo Branco on 25/12/22.
//

import SwiftUI

struct TypePill: View {
  init(_ type: PokemonType) {
    self.type = type
  }

  let type: PokemonType

    var body: some View {
      Text(type.rawValue.uppercased())
        .font(.system(.caption2, weight: .bold))
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .foregroundColor(.white)
        .background(type.getColor())
        .cornerRadius(100)
    }
}

struct TypePill_Previews: PreviewProvider {
    static var previews: some View {
      TypePill(.grass)
    }
}
