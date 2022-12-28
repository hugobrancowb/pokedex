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
        switch viewModel.state {
        case .data(let data):
          LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 8) {
            ForEach(data, id: \.name) { pokemon in
              PokemonMiniCard(pokemon: pokemon)
                .task {
                  // if we're at the last pokemon, load more
                  if (data.last?.id == pokemon.id) {
                    viewModel.search(loadMore: true)
                  }
                }
            }
          }

        case .loading:
          ProgressView()

        case .error:
          ErrorLoading()
        }
      }
      .padding()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      // TODO: swap search bar for generation toggles or maybe other kinds of filters
      .homeToolbar()
      .navigationBarTitleDisplayMode(.inline)
      .background(.background)
    }
    .preferredColorScheme(.light)
    .searchable(text: $searchQuery, prompt: "Search")
    .task {
      viewModel.search()
    }
    .refreshable {
      viewModel.search()
    }
  }

  private struct ErrorLoading: View {
    var body: some View {
      HStack (spacing: 8) {
        Image(systemName: "xmark.circle")

        Text("Error fetching pokemons")
          .font(.body)
      }
      .foregroundColor(.red)
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
