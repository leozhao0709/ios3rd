//
//  ContentView.swift
//  SpeechSynthesis
//
//  Created by Lei Zhao on 11/23/20.
//
//

import SwiftUI
import AVFoundation

struct ContentView: View {

    let text = "明明，好臭啊！"
    @State var pitchMultiplier: Float = 1

    var body: some View {
        VStack {
            Text(text)
              .padding()

            VStack{
                Text("pitchMultiplier: \(pitchMultiplier)")
                Slider(value: $pitchMultiplier, in: 0.5...2, step: 0.1)
            }

            Button("play") {
                let synthesizer = AVSpeechSynthesizer()
                let speakMsg = AVSpeechUtterance(string: text)
                // locale
                speakMsg.voice = AVSpeechSynthesisVoice(language: "zh-CN")
                // 音调
                speakMsg.pitchMultiplier = pitchMultiplier
                // 语速
                speakMsg.rate = 0.5

                synthesizer.speak(speakMsg)

//                // get all locale
//                for voice in (AVSpeechSynthesisVoice.speechVoices()){
//                    print(voice.language)
//                }
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
