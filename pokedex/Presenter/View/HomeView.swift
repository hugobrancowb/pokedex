//
//  ContentView.swift
//  pokedex
//
//  Created by Hugo Branco on 20/12/22.
//

import SwiftUI

struct HomeView: View {
  @State var searchQuery = ""

  var body: some View {
    NavigationView {
      ScrollView {
        // MARK: Grid of PokeCard
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 16) {
          ForEach(0 ..< 12) { item in
            PokemonMiniCard()
          }
        }
      }
      .padding()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .homeToolbar()
      .background(.background)
    }
    .searchable(text: $searchQuery, prompt: "Search")
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
