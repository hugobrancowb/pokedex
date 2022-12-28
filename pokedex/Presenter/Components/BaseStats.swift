//
//  BaseStats.swift
//  pokedex
//
//  Created by Hugo Branco on 25/12/22.
//

import SwiftUI

struct BaseStats: View {
  let type: PokemonType?

  let hp: Int
  let atk: Int
  let def: Int
  let satk: Int
  let sdef: Int
  let spd: Int

  var color: Color { type?.getColor() ?? Color.mediumGray }

  var body: some View {
    HStack {
      // MARK: Labels
      VStack (alignment: .trailing, spacing: 4) {
        Label("hp")
        Label("atk")
        Label("def")
        Label("satk")
        Label("sdef")
        Label("spd")
      }
      .foregroundColor(color)

      Divider()

      // MARK: Bars
      VStack (alignment: .trailing, spacing: 4) {
        ProgressBar(value: hp, color: color, order: 1)
        ProgressBar(value: atk, color: color, order: 2)
        ProgressBar(value: def, color: color, order: 3)
        ProgressBar(value: satk, color: color, order: 4)
        ProgressBar(value: sdef, color: color, order: 5)
        ProgressBar(value: spd, color: color, order: 6)
      }
    }
  }

  private struct Label: View {
    init(_ text: String) { self.text = text }

    let text: String

    var body: some View {
      Text(text.uppercased())
        .font(.system(.caption2, weight: .bold))
    }
  }

  private struct ProgressBar: View {
    @State var progressValue = 0
    private let delay: CGFloat = 0.1

    let value: Int
    let maxValue: Int = 250
    let color: Color
    let order: Int

    var label: String {
      return ""
        .appending(repeatElement("0", count: 3 - value.description.count).joined())
        .appending(value.description)
    }

    var body: some View {
      HStack (alignment: .center) {
        Text(label)
          .font(.caption2)
          .foregroundColor(Color.mediumGray)

        Rectangle()
          .fill(color)
          .opacity(0.2)
          .frame(maxHeight: 4)
          .overlay {
            Rectangle()
              .fill(color)
              .scaleEffect(x: CGFloat(progressValue)/CGFloat(maxValue), anchor: .leading)
              .animation(.easeInOut(duration: 0.6).delay(CGFloat(order - 1) * delay), value: progressValue)
          }
          .cornerRadius(100)
          .onAppear {
            progressValue = value
          }
      }
    }
  }
}
