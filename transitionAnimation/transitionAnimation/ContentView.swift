//
//  ContentView.swift
//  transitionAnimation
//
//  Created by Lei Zhao on 11/8/20.
//
//

import SwiftUI

struct ContentView: View {

    @State(initialValue: false) private var showDetail

    var body: some View {
        Text("iPhone11")
            .onTapGesture {
//                withAnimation {
                    showDetail.toggle()
//                }
            }

        if showDetail {
            DetailView()
              .transition(.slide)
              .animation(.easeInOut)
        }

//        .fullScreenCover(isPresented: $showDetail) {
////            if showDetail {
//                DetailView()
//                  .transition(.slide)
////            }
//        }
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
