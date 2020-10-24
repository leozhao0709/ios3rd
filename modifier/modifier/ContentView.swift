//
//  ContentView.swift
//  modifier
//
//  Created by Lei Zhao on 10/23/20.
//
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    Color.blue
      .frame(maxWidth: 300, maxHeight: 200)
//      .modifier(Watermark(text: "123"))
      .watermark(text: "123")
  }
}

struct Watermark: ViewModifier {
  let text: String

  func body(content: Content) -> some View {
    ZStack(alignment: .bottomTrailing){
      content
      Text(text)
        .foregroundColor(.white)
        .padding()
        .background(Color.black)
        .offset(x: -20, y: -20)
    }
  }
}

extension View {
  func watermark(text: String) -> some View {
    ZStack(alignment: .bottomTrailing){
      self
      Text(text)
        .foregroundColor(.white)
        .padding()
        .background(Color.black)
        .offset(x: -20, y: -20)
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
