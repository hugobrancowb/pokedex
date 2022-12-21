//
//  ContentView.swift
//  pokedex
//
//  Created by Hugo Branco on 20/12/22.
//

import SwiftUI

struct ContentView: View {
  @State var searchQuery = ""

  var body: some View {
    NavigationView {
      ScrollView {
//        Image(systemName: "globe")
//          .imageScale(.large)
//          .foregroundColor(.accentColor)
//
//        Text("Hello, world!")
      }
      .toolbar {
        // MARK: Title
        ToolbarItem(placement: .navigationBarLeading) {
          HStack(spacing: 16) {
          Image("Pokeball")
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .frame(width: 24)

          Text("Pokédex")
            .font(.system(size: 24, weight: .bold))
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
    }
    .searchable(text: $searchQuery, prompt: "Search")

  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
