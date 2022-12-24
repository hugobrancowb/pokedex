//
//  ContentView.swift
//  pokedex
//
//  Created by Hugo Branco on 20/12/22.
//

import SwiftUI

struct HomeView: View {
  @State var searchQuery = ""

  @StateObject var viewModel = HomeViewModel()

  var body: some View {
    NavigationView {
      ScrollView {
        // MARK: Grid of PokeCard
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 16) {
          ForEach(viewModel.results, id: \.name) { pokemon in
            PokemonMiniCard(pokemon: pokemon)
              .task {
                // if we're at the last pokemon, load more
                if (viewModel.results.last?.id == pokemon.id) {
                  await viewModel.search(loadMore: true)
                }
              }
          }
        }
      }
      .padding()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .homeToolbar()
      .background(.background)
    }
    .searchable(text: $searchQuery, prompt: "Search")
    .task {
      await viewModel.search()
    }
    .refreshable {
      await viewModel.search()
    }
  }

}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
