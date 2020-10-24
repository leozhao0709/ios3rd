//
//  ContentView.swift
//  guessFlag
//
//  Created by Lei Zhao on 10/23/20.
//
//

import SwiftUI

struct ContentView: View {
  @State private var countries = ["中国", "俄罗斯", "德国", "意大利", "日本", "法国", "美国", "英国"]
  @State private var currentCountryIndex = Int.random(in: 0..<3)
  @State private var showAlert = false
  @State private var alertTitle: String = ""

  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .top, endPoint: .bottom)
        .ignoresSafeArea()
      VStack {
        VStack(spacing: 30) {
          Text("以下国家的旗帜是哪一个")
            .foregroundColor(.white)
          Text(countries[currentCountryIndex])
            .font(.title)
            .foregroundColor(.white)
          ForEach(0..<3) { index in
            Button(action: { handleImageClick(index: index) }) {
              Image(countries[index])
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                .shadow(color: .black, radius: 2)
            }
          }
        }
        Spacer()
      }
        .offset(y: 20)
    }.alert(isPresented: $showAlert) { () -> Alert in
      Alert(title: Text(self.alertTitle), message: nil, dismissButton: .default(Text("继续")) {
        if (self.alertTitle == "答错了") {
          return
        }
        countries.shuffle()
        self.currentCountryIndex = Int.random(in: 0...2)
      })
    }
  }

  func handleImageClick(index: Int) {
    self.showAlert = true
    self.alertTitle = index == self.currentCountryIndex ? "答对了" : "答错了"
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
