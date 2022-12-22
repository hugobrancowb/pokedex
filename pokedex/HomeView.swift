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
        // MARK: PokeCard

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

            Text("Charmander")
              .font(.pokereg(size: 10))
              .foregroundColor(.white)
            }
          }
          .cornerRadius(8)
        }
        .frame(width: 100, height: 100, alignment: .center)
        .aspectRatio(1, contentMode: .fit)

      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .toolbar {
        // MARK: Title
        ToolbarItem(placement: .navigationBarLeading) {
          HStack(spacing: 16) {
          Image("Pokeball")
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .frame(width: 24)

          Text("Pokédex")
              .font(.pokebold(size: 24))
          }
        }

        // MARK: Filter action
        ToolbarItem(placement: .primaryAction) {
          Image(systemName: "line.3.horizontal.decrease.circle")
            .onTapGesture {
              // TODO: Open filter Menu
            }
        }
      }
      .background(Color("background"))
    }
    .searchable(text: $searchQuery, prompt: "Search")
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
