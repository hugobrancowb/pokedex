//
//  PokemonMetrics.swift
//  pokedex
//
//  Created by Hugo Branco on 25/12/22.
//

import SwiftUI

struct PokemonMetrics: View {
  let height: String
  let weight: String

  var body: some View {
    HStack {
      // MARK: Weight
      VStack {
        HStack (alignment: .bottom) {
          Image("Weight")
          Text(weight + "kg")
            .font(.caption)
        }

        Text("Weight")
          .font(.caption2)
          .padding(.top, 4)
          .foregroundColor(Color.mediumGray)
      }

      Divider()
        .padding(.horizontal, 24)

      // MARK: Height
      VStack {
        HStack (alignment: .bottom) {
          Image("Height")
          Text(height + "m")
            .font(.caption)
        }

        Text("Height")
          .font(.caption2)
          .padding(.top, 4)
          .foregroundColor(Color.mediumGray)
      }
    }
  }
}

struct PokemonMetrics_Previews: PreviewProvider {
  static var previews: some View {
    PokemonMetrics(height: "1.2", weight: "6.9")
  }
}
