//
//  ContentView.swift
//  contact
//
//  Created by Lei Zhao on 10/31/20.
//
//

import SwiftUI

struct ContentView: View {
    @State(initialValue: 0) private var tabIndex

    var body: some View {
        TabView(selection: $tabIndex) {
            CoderView(coderType: .all)
              .tabItem {
                  Image(systemName: "person.3")
                  Text("所有开发者")
              }
              .tag(0)

            CoderView(coderType: .apple)
              .tabItem {
                  Image(systemName: "person")
                  Text("苹果开发者")
              }
              .tag(1)

            CoderView(coderType: .android)
              .tabItem {
                  Image(systemName: "person")
                  Text("安卓开发者")
              }
              .tag(2)
        }
          .environmentObject(Coders())
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
