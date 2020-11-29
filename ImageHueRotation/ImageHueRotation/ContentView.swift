//
//  ContentView.swift
//  ImageHueRotation
//
//  Created by Lei Zhao on 11/28/20.
//
//

import SwiftUI

struct ContentView: View {

    @State private var shiftColors = false
    @State private var image = "dog"

    var body: some View {
        VStack {
            ZStack {
                Color.black
                Image(image)
                  .resizable()
                  .frame(height: 350)
                  .scaledToFit()
                  .hueRotation(.degrees(shiftColors ? 360 : 0))
                  .animation(
                    Animation.easeInOut(duration: 2)
                      .repeatForever(autoreverses: true)
                  )
                  .onAppear {
                      self.shiftColors.toggle()
                  }
            }
        }
          .ignoresSafeArea()
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
