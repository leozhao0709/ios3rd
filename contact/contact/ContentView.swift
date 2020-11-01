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
            Color.red
                .tabItem { Text("red")  }
                .tag(0)

            Color.orange
              .tabItem { Text("orange")  }
              .tag(1)

            Color.blue
              .tabItem { Text("blue")  }
              .tag(2)

            Color.yellow
              .tabItem { Text("yellow")  }
              .tag(3)
        }
        Button("123") {
            print("....\(tabIndex)")
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
