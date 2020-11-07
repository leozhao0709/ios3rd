//
//  ContentView.swift
//  dice
//
//  Created by Lei Zhao on 11/5/20.
//
//

import SwiftUI
import Combine
import ProgressHUD

let shakeSubject = PassthroughSubject<Void, Never>()

struct ContentView: View {

    @State(initialValue: 1) private var index1
    @State(initialValue: 1) private var index2


    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Image("newbackground")
                  .resizable()
                  .scaledToFill()
                  .frame(width: proxy.size.width, height: proxy.size.height)
                VStack(alignment: .center) {
                    ProgressView(value: 0.25)
                      .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
//                      .shadow(color: Color(red: 0, green: 0, blue: 0.6),
//                        radius: 4.0, x: 1.0, y: 2.0)

                    Image("diceeLogo")
                        .padding(.bottom, 50)

                    HStack {
                        Image("dice\(index1)")
                        Spacer()
                        Image("dice\(index2)")
                    }
                      .padding([.leading, .trailing])
                      .padding(.bottom, 100)

                    Button(action: handleUpdateDice, label: {
                        Text("Roll")
                          .fontWeight(.bold)
                          .padding([.bottom, .top])
                          .padding(.leading, 50)
                          .padding(.trailing, 50)
                          .foregroundColor(.white)
                          .background(Color.pink)

                    })
                }
            }
                .onReceive(shakeSubject, perform: handleUpdateDice)
        }
          .ignoresSafeArea()
    }

    func handleUpdateDice() {
        index1 = Int.random(in: 1...6)
        index2 = Int.random(in: 1...6)
//        ProgressHUD.animationType = .circleStrokeSpin
//        ProgressHUD.colorStatus = .label
//        ProgressHUD.colorBackground = .lightGray
//        ProgressHUD.colorProgress = .systemBlue
    }
}

extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            shakeSubject.send()
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
