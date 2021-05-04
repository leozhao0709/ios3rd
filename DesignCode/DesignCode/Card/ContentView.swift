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
    @State(initialValue: false) var showCard
    @State(initialValue: CGSize.zero) var bottomCardOffsetState
    @State var showFullBottomCard = false

    var body: some View {
        ZStack {
            TitleView()
              .blur(radius: show ? 20 : 0)
              .opacity(showCard ? 0.4 : 1)
              .offset(y: showCard ? -200 : 0)
              .animation(.default.delay(0.1))

            BackCardView(color: Color(show ? "card3" : "card4"))
              .frame(width: showCard ? 300 : 340, height: 220)
              .offset(x: 0, y: show ? -400 : -40)
              .offset(viewState)
              .offset(y: showCard ? -180 : 0)
              .scaleEffect(showCard ? 1 : 0.9)
              .rotationEffect(.degrees(show ? 0 : 10))
              .rotationEffect(.degrees(showCard ? -10 : 0))
              .rotation3DEffect(.degrees(showCard ? 0 : 10), axis: (x: 10, y: 0, z: 0))
              .blendMode(.hardLight)
              .animation(.easeInOut(duration: 0.5))

            BackCardView(color: Color(show ? "card4" : "card3"))
              .frame(width: 340, height: 220)
              .offset(x: 0, y: show ? -200 : -20)
              .offset(viewState)
              .offset(y: showCard ? -140 : 0)
              .scaleEffect(showCard ? 1 : 0.95)
              .rotationEffect(Angle(degrees: show ? 0 : 5.0))
              .rotationEffect(.degrees(showCard ? -5 : 0))
              .rotation3DEffect(.degrees(showCard ? 0 : 5), axis: (x: 10, y: 0, z: 0))
              .blendMode(.hardLight)
              .animation(.easeInOut(duration: 0.3))

            CardView()
              .frame(width: showCard ? 375 : 340.0, height: 220.0)
              .background(Color.black)
              .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20))
              .shadow(radius: 20)
              .contentShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20))
              .blendMode(.hardLight)
              .offset(viewState)
              .offset(y: showCard ? -100 : 0)
              .onTapGesture {
                  showCard.toggle()
              }
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
              .offset(y: showCard ? 360 : 1000)
              .offset(bottomCardOffsetState)
              .blur(radius: show ? 20 : 0)
              .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
              .gesture(DragGesture()
                .onChanged { value in
                    if (value.translation.height < 0 && showFullBottomCard) {
                        return
                    }
                    if (showFullBottomCard) {
                        bottomCardOffsetState.height = value.translation.height - 300
                        return
                    }
                    bottomCardOffsetState.height = value.translation.height
                }.onEnded { (v: DragGesture.Value) in
                    if (bottomCardOffsetState.height > 50) {
                        showCard = false
                        bottomCardOffsetState.height = .zero
                    }
                    if (bottomCardOffsetState.height < -100 && !showFullBottomCard || showFullBottomCard && bottomCardOffsetState.height < -250) {
                        bottomCardOffsetState.height = -300
                        showFullBottomCard = true
                    } else {
                        showFullBottomCard = false
                        bottomCardOffsetState = .zero
                    }
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
