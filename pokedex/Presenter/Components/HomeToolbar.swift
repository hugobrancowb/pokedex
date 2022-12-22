//
//  AppTitle.swift
//  pokedex
//
//  Created by Hugo Branco on 21/12/22.
//

import SwiftUI

extension View {
  public func homeToolbar() -> some View {
    return self
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
  }
}
