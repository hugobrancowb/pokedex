//
//  AppTitle.swift
//  pokedex
//
//  Created by Hugo Branco on 21/12/22.
//

import SwiftUI

extension View {
  public func homeToolbar(selectedGen: Int, onFilterChange: @escaping (Int) -> Void) -> some View {
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
          Menu(content: {
            Button("1st Gen") {
              onFilterChange(1)
            }
            
            Button("2nd Gen") {
              onFilterChange(2)
            }
            
            Button("3rd Gen") {
              onFilterChange(3)
            }
            
            Button("4rd Gen") {
              onFilterChange(4)
            }
            
            //            Button("5th Gen") {
            //              onFilterChange(5)
            //            }
            //
            //            Button("6th Gen") {
            //              onFilterChange(6)
            //            }
            //
            //            Button("7th Gen") {
            //              onFilterChange(7)
            //            }
            //
            //            Button("8th Gen") {
            //              onFilterChange(8)
            //            }
            //
            //            Button("9th Gen") {
            //              onFilterChange(9)
            //            }
            
          }, label: {
            Image(systemName: "line.3.horizontal.decrease.circle")
              .foregroundColor(.darkGray)
              .onTapGesture {
                // TODO: Open filter Menu
              }
          })
        }
      }
  }
}
