//
//  PokemonMiniCard.swift
//  pokedex
//
//  Created by Hugo Branco on 21/12/22.
//

import SwiftUI

struct PokemonMiniCard: View {
  let name: String

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 8)
        .fill()
        .foregroundColor(.white)
        .overlay {
          RoundedRectangle(cornerRadius: 8)
            .strokeBorder(Color("type-fire"), lineWidth: 1)
        }

      VStack {
        ZStack(alignment: .topTrailing) {
          Text("#001")
            .font(.pokereg(size: 8))
            .foregroundColor(Color("type-fire"))
            .frame(maxWidth: .infinity, alignment: .trailing)

          // TODO: swap for async image with cache and shimmer as fallback
          Image("Pokeball")
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .padding(.top, 8)
        .padding(.horizontal, 8)

        ZStack {
          RoundedRectangle(cornerRadius: 0)
            .foregroundColor(Color("type-fire"))
            .frame(height: 24)

          Text(name)
            .font(.pokereg(size: 10))
            .foregroundColor(.white)
        }
      }
      .cornerRadius(8)
    }
    .aspectRatio(1, contentMode: .fit)
  }
}
