//
//  ContentView.swift
//  record
//
//  Created by Lei Zhao on 11/12/20.
//
//

import SwiftUI

struct ContentView: View {
    @State private var btnTitle: String = "start recording"
    @State(initialValue: false) private var btnIsPressing

    private let audioManager = AudioManager.sharedInstance
    private let recordManager = RecordManager.sharedInstance

    var body: some View {
        Button(btnTitle) {
            self.btnTitle = "start recording"
            self.btnIsPressing.toggle()
            recordManager.stopRecord()
        }
          .onLongPressGesture(pressing: { pressing in
              if pressing {
                  self.btnIsPressing.toggle()
                  self.btnTitle = "stop recording"
                  recordManager.startRecord()
              }
          }, perform: {})
          .font(.largeTitle)
          .buttonStyle(MyButtonStyle())

        Button("play audio") {
            let url = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents/record.m4a")
//            let url = Bundle.main.url(forResource: "note1.wav", withExtension: nil)
            print(url)
            audioManager.playAudio(url: url)
        }
          .font(.largeTitle)
          .padding()
    }
}

struct MyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
          .padding()
          .foregroundColor(configuration.isPressed ? Color.white : Color.blue)
          .background(configuration.isPressed ? Color.green : Color.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
