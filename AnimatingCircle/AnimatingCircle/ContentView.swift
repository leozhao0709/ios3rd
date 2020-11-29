//
//  ContentView.swift
//  AnimatingCircle
//
//  Created by Lei Zhao on 11/28/20.
//
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Rectangle()
            CircleGroup()
            CircleGroup()
                .rotationEffect(.degrees(60))
            CircleGroup()
              .rotationEffect(.degrees(120))
        }
          .ignoresSafeArea()
          .background(Color.black)

    }
}

struct CircleGroup: View {

    @State private var collapse = true
    @State private var rotate = false
    @State private var scale = false

    var body: some View {
        ZStack {
            BaseCircle()
              .rotationEffect(.degrees(180))
              .offset(y: self.collapse ? 0 : -60)
            BaseCircle()
                .offset(y: self.collapse ? 0 : 60)
        }
            .opacity(0.5)
            .rotationEffect(.degrees(self.rotate ? 90 : 0))
            .scaleEffect(self.scale ? 1 : 1/4)
            .animation(
              Animation
                .easeInOut(duration: 2)
                .repeatForever(autoreverses: true)
            )
            .onAppear {
                self.collapse.toggle()
                self.rotate.toggle()
                self.scale.toggle()
            }
    }
}

struct BaseCircle: View {
    var body: some View {
        Circle()
          .fill(
            LinearGradient(
              gradient: Gradient(colors: [.green, .white]),
              startPoint: .bottom,
              endPoint: .top
            )
          )
          .frame(height: 120)
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
