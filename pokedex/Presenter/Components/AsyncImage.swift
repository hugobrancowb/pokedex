//
//  AsyncImage.swift
//  pokedex
//
//  Created by Hugo Branco on 24/12/22.
//

import SwiftUI

struct ImageCached: View {
  let url: String

  var body: some View {
    AsyncImage(url: URL(string: url)) { phase in
      switch phase {
      case .success(let image):
        image
          .resizable()
          .aspectRatio(1, contentMode: .fit)
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
      default:
        Image("Pokeball")
          .resizable()
          .aspectRatio(1, contentMode: .fit)
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
      }
    }
  }
}

struct ImageCached_Previews: PreviewProvider {
  static var previews: some View {
    ImageCached(url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
  }
}
