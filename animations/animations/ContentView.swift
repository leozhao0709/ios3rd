//
//  ContentView.swift
//  animations
//
//  Created by Lei Zhao on 10/24/20.
//
//

import SwiftUI

struct ContentView: View {

  var body: some View {
    TransitionAnimation()
  }
}

struct TransitionAnimation: View {

  @State(initialValue: false) private var show

  var body: some View {
    VStack {
      Button("click to Toggle") {
        withAnimation {
          self.show.toggle()
        }
      }
      if show {
        Color.green.frame(maxWidth: 200, maxHeight: 100)
          .transition(.asymmetric(insertion: .scale, removal: .opacity))
      }
    }
  }
}

struct ExplicitAnimation: View {

  @State(initialValue: 0.0) private var rotateDeg

  var body: some View {
    Button("click") {
      withAnimation(Animation.interpolatingSpring(stiffness: 2, damping: 1)) {
        self.rotateDeg += 360
      }
    }
      .padding(30)
      .foregroundColor(.white)
      .background(Color.black)
      .clipShape(Circle())
      .rotation3DEffect(.degrees(rotateDeg), axis: (0, 1, 0))
  }
}

struct ImplicitAnimation: View {
  @State private var scaleAmount: CGFloat = 1.0

  var body: some View {
    VStack {
      Button("Click") {
      }
        .foregroundColor(.white)
        .padding(20)
        .background(Color.red)
        .clipShape(Circle())
        .overlay(
          Circle()
            .stroke(Color.red)
            .scaleEffect(scaleAmount)
            .opacity(Double(2 - scaleAmount))
            .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: false)))
    }.onAppear {
      self.scaleAmount = 2
    }
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
