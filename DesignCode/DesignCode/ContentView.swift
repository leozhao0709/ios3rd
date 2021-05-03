//
//  ContentView.swift
//  DesignCode
//
//  Created by Lei Zhao on 5/2/21.
//
//

import SwiftUI

struct ContentView: View {

    @State(initialValue: false) var show
    @State(initialValue: CGSize.zero) var viewState

    var body: some View {
        ZStack {
            TitleView()
                .blur(radius: show ? 20 : 0)
                .animation(.default)

            BackCardView(color: Color(show ? "card3":"card4"))
              .offset(x: 0, y: show ? -400 : -40)
              .offset(viewState)
              .scaleEffect(0.9)
              .rotationEffect(.degrees(show ? 0 : 10))
              .rotation3DEffect(.degrees(10), axis: (x: 10, y: 0, z: 0))
              .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5))

            BackCardView(color: Color(show ? "card4":"card3"))
              .offset(x: 0, y: show ? -200 : -20)
              .offset(viewState)
              .scaleEffect(0.95)
              .rotationEffect(Angle(degrees: show ? 0 : 5.0))
              .rotation3DEffect(.degrees(5), axis: (x: 10, y: 0, z: 0))
              .blendMode(.hardLight)
              .animation(.easeInOut(duration: 0.3))

            CardView()
              .blendMode(.hardLight)
              .onTapGesture {
                  show.toggle()
              }
              .offset(viewState)
              .animation(.spring(response: 0.3, dampingFraction: 0.6))
            .gesture(
              DragGesture()
              .onChanged { value in
                  viewState = value.translation
                  show = true
              }
              .onEnded { (v: DragGesture.Value) in
                  viewState = .zero
                  show = false
              }
            )

            BottomCardView()
              .blur(radius: show ? 20 : 0)
              .animation(.default)
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
