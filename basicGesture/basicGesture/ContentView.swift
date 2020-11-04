//
//  ContentView.swift
//  gestureTest
//
//  Created by Lei Zhao on 11/2/20.
//
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 16) {
            TextWithBackground("single tap")
              .onTapGesture {
                  print("single tap")
              }

            TextWithBackground("double tap")
              .onTapGesture(count: 2) {
                  print("double tap")
              }

            TextWithBackground("long press")
              .onLongPressGesture(
                minimumDuration: 2,
                pressing: { isPressing in print("isPressing...") },
                perform: {
                    print("long pressing")
                })
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
