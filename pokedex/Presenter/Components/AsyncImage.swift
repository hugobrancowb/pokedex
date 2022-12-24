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
    if let cached = Cache[url] {
      cached.expandImageSize()
    } else {
      AsyncImage(url: URL(string: url)) { phase in
        switch phase {
        case .success(let image):
          let _ = Cache[url] = image

          image.expandImageSize()
        default:
          Image("Pokeball").expandImageSize()
        }
      }
    }
  }
}

fileprivate class Cache {
  static private var cache: [String: Image] = [:]

  static subscript(url: String) -> Image? {
    get { Cache.cache[url] }
    set { Cache.cache[url] = newValue }
  }
}

private extension Image {
  func expandImageSize() -> some View {
    return self
      .resizable()
      .aspectRatio(1, contentMode: .fit)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
  }
}

struct ImageCached_Previews: PreviewProvider {
  static var previews: some View {
    ImageCached(url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
  }
}
