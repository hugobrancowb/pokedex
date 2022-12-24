//
//  PokemonMiniCard.swift
//  pokedex
//
//  Created by Hugo Branco on 21/12/22.
//

import SwiftUI

struct PokemonMiniCard: View {
  let pokemon: PokemonCompactModel
  
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
      
      VStack {
        ZStack(alignment: .topTrailing) {
          Text(hashId)
            .font(.pokereg(size: 8))
            .foregroundColor(typeColor)
            .frame(maxWidth: .infinity, alignment: .trailing)
          
          // TODO: swap for async image with cache and shimmer as fallback
          ImageCached(url: pokemon.sprites.front_default)
        }
        .padding(.top, 8)
        .padding(.horizontal, 8)
        
        ZStack {
          RoundedRectangle(cornerRadius: 0)
            .foregroundColor(typeColor)
            .frame(height: 24)
          
          Text(pokemon.name)
            .font(.pokereg(size: 10))
            .foregroundColor(.white)
        }
      }
      .cornerRadius(8)
    }
    .aspectRatio(1, contentMode: .fit)
  }
}

struct PokemonMiniCard_Previews: PreviewProvider {
  //  let pokemon = PokemonCompactModel(id: 1, name: "bulbasaur", sprites: SpriteModel(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", back_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"), types: [PokemonTypeModel(slot: 1, type: PokemonTypeModel.PokemonTypeDetails(name: PokemonType.grass, url: ""))])

  static var previews: some View {
    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 16) {
      PokemonMiniCard(pokemon: PokemonCompactModel(id: 1, name: "bulbasaur", sprites: SpriteModel(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", back_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"), types: [PokemonTypeModel(slot: 1, type: PokemonTypeModel.PokemonTypeDetails(name: PokemonType.grass, url: ""))]))
    }
    .padding()
  }
}

