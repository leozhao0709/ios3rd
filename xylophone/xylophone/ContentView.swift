//
//  ContentView.swift
//  xylophone
//
//  Created by Lei Zhao on 11/5/20.
//
//

import SwiftUI
import AVFoundation

struct ContentView: View {

    let keys: [Color] = [.red, .orange, .yellow, .green, .pink, .blue, .purple]
    @State var audioPlayer: AVAudioPlayer?

    var body: some View {
        ForEach(keys.indices) { index in
            Rectangle()
              .fill(keys[index])
              .padding([.leading, .trailing], 5 * CGFloat(index + 1))
              .onTapGesture {
                  guard let url = Bundle.main.url(forResource: "note\(index+1)", withExtension: "wav") else {
                      print("url read fail")
                      return
                  }
                  guard let audioPlayer = try? AVAudioPlayer(contentsOf: url) else {
                      print("audioPlayer create fail")
                      return
                  }

                  self.audioPlayer = audioPlayer
                  audioPlayer.play()
              }
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
