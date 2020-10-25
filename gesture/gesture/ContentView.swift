//
//  ContentView.swift
//  gesture
//
//  Created by Lei Zhao on 10/24/20.
//
//

import SwiftUI

struct ContentView: View {

  @State(initialValue: CGSize.zero) private var offset

  var body: some View {
    LinearGradient(
      gradient: Gradient(colors: [.yellow, .red]),
      startPoint: .topLeading,
      endPoint: .bottomTrailing
    )
      .frame(maxWidth: 300, maxHeight: 200)
      .clipShape(RoundedRectangle(cornerRadius: 10))
      .offset(offset)
      .gesture(
        DragGesture()
          .onChanged { value in
            print("...location...", value.location)
            print("...translation...", value.translation)
            self.offset = value.translation
          }
          .onEnded { _ in
            withAnimation(Animation.easeInOut(duration: 1)) {
              self.offset = CGSize.zero
            }
          }
      )
  }
}

class ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }

  #if DEBUG
    @objc class func injected() {
      UIApplication.shared.windows.first?.rootViewController =
        UIHostingController(rootView: ContentView_Previews.previews)
    }
  #endif
}
