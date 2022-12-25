//
//  AsyncImage.swift
//  pokedex
//
//  Created by Hugo Branco on 24/12/22.
//

import SwiftUI

struct ImageCached: View {
  /// Image's url
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
        case .empty:
          Shimmer()
        case .failure:
          Image("Placeholder").expandImageSize()
        @unknown default:
          fatalError()
        }
      }
    }
  }

  /// Placeholder for image loading with shimmer-like effect
  private struct Shimmer: View {
    @State private var opacity: CGFloat = 0.2

    var body: some View {
      ZStack {
        Image("Placeholder")
          .expandImageSize()
          .opacity(opacity)
          .contentTransition(.interpolate)
          .onAppear {
            withAnimation(Animation.easeInOut(duration: 0.7).repeatForever(autoreverses: true)) {
              opacity = 0.4
            }
        }

        ProgressView()
      }
    }
  }
}

/// Caches images in runtime memory
fileprivate class Cache {
  static private var cache: [String: Image] = [:]

  static subscript(url: String) -> Image? {
    get { Cache.cache[url] }
    set { Cache.cache[url] = newValue }
  }
}

/// Resizes images for filling the parent space proportionally
private extension Image {
  func expandImageSize() -> some View {
    return self
      .resizable()
      .aspectRatio(1, contentMode: .fit)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
  }
}
