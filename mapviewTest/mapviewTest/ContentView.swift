//
//  ContentView.swift
//  mapviewTest
//
//  Created by Lei Zhao on 10/30/20.
//
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MapView()
            .frame(height: 300)
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
