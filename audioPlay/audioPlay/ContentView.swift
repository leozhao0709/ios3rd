//
//  ContentView.swift
//  audioPlay
//
//  Created by Lei Zhao on 11/13/20.
//
//

import SwiftUI

struct ContentView: View {

    let audioManager = AudioManager.sharedInstance
    let url = Bundle.main.url(forResource: "爸爸去哪儿.mp3", withExtension: nil)
    @State private var isPlaying: Bool?
    @State(initialValue: false) private var isMute
    @State(initialValue: 0.5) private var volume
    @State(initialValue: 1) private var numOfLoop

    var body: some View {
        VStack {
            HStack {
                Button("Star") {
                    self.numOfLoop = 1
                    audioManager.startNewAudio(url: url!, onFinishingPlaying: { b in
                        print("....finish....")
                        self.numOfLoop -= 1
                    })
                    self.isPlaying = true
                }
                if let isPlaying = self.isPlaying {
                    if isPlaying {
                        Button("Pause") {
                            audioManager.pauseAudio()
                            self.isPlaying = false
                        }
                    } else {
                        Button("Resume") {
                            audioManager.resumeAudio()
                            self.isPlaying = true
                            audioManager.setAudioPlayTime(timeInterval: 270)
                        }
                    }
                }
                Button("Stop") {
                    audioManager.stopAudio()
                    self.isPlaying = nil
                }
            }

            HStack {
                Button("Mute") {
                    self.isMute.toggle()
                }
                Toggle("", isOn: $isMute)
                  .labelsHidden()
                  .onChange(of: isMute) {
                      $0 ? audioManager.muteAudio() : audioManager.unmuteAudio()
                  }
            }

            HStack {
                Text("Vol")
                Slider(value: $volume, in: 0...1, step: 0.1)
                  .onChange(of: volume) {
                      audioManager.setAudioVolume(volume: Float($0))
                  }
            }
              .padding(
                [.leading, .trailing], 40
              )

            HStack {
                Text("Num of Loop: \(self.numOfLoop)")
                Stepper("", value: $numOfLoop, step: 1).labelsHidden()
                  .onChange(of: numOfLoop) { loop in
                      audioManager.setAudioPlayerLoop(num: loop)
                  }
            }
              .padding(
                [.leading, .trailing], 40
              )

            Text("\(audioManager.getAudioDuration())")
        }
          .onAppear {
              audioManager.setAudioVolume(volume: Float(self.volume))
          }
    }
}