//
//  PokemonMiniCard.swift
//  pokedex
//
//  Created by Hugo Branco on 21/12/22.
//

import SwiftUI

struct PokemonMiniCard: View {
  /// Pokemon information
  let pokemon: PokemonCompactModel

  /// Pokemon number prefixed with # and always having 3 digits
  var hashId: String {
    let number = pokemon.id.description
    return "#"
      .appending(repeatElement("0", count: 3 - number.count).joined())
      .appending(number)
  }
  
  var typeColor: Color {
    guard let type = pokemon.types.first else { return Color.gray }
    return type.type.name.getColor()
  }
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 8)
        .fill()
        .foregroundColor(.white)
        .overlay {
          RoundedRectangle(cornerRadius: 8)
            .strokeBorder(typeColor, lineWidth: 1)
        }
      
      VStack (spacing: 0) {
        ZStack(alignment: .topTrailing) {
          Text(hashId)
            .font(.pokereg(size: 8))
            .foregroundColor(typeColor)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.bottom, 4)

          ImageCached(url: pokemon.sprites.official)
        }
        .padding(.top, 8)
        .padding(.horizontal, 8)
        
        ZStack {
          RoundedRectangle(cornerRadius: 0)
            .foregroundColor(typeColor)
            .frame(height: 24)

          Text(pokemon.name.capitalized)
            .font(.caption)
            .foregroundColor(.white)
        }
      }
      .cornerRadius(8)
    }
    .aspectRatio(1, contentMode: .fit)
  }
}

struct PokemonMiniCard_Previews: PreviewProvider {
  static var previews: some View {
    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 16) {
      PokemonMiniCard(pokemon: PokemonCompactModel(id: 1, name: "bulbasaur", sprites: SpriteModel(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", back_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
                                                                                                  other: SpriteModel.OtherSprites(officialArtwork: SpriteModel.OtherSprites.OfficialArtwork(
                                                                                                    frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png")
                                                                                                  )                  ), types: [PokemonTypeModel(slot: 1, type: PokemonTypeModel.PokemonTypeDetails(name: PokemonType.grass, url: ""))]))
    }
    .padding()
  }
}

