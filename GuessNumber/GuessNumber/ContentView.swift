//
//  ContentView.swift
//  GuessNumber
//
//  Created by Lei Zhao on 11/23/20.
//

import SwiftUI
import Speech
import SwiftMusings

struct ContentView: View {

    @State var btnTitle = "Hold To Speak"
    @State var btnIsPressing = false
    let audioManager = AudioManager.shared
    let audioUrl = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents/record.m4a")

    var body: some View {
        ZStack {
            GeometryReader { (proxy: GeometryProxy) in
                Image("bg")
                  .resizable()
                  .scaledToFill()

                VStack {
                    Image("mic")
                    Text("Guess a Number Between      1 - 100")
                      .multilineTextAlignment(.center)
                      .font(.largeTitle)
                      .foregroundColor(.white)
                    Button(btnTitle) {
                    }
                      .padding()
                      .onLongPressGesture(pressing: { isPressing in
                          if isPressing {
                              self.btnIsPressing.toggle()
                              self.startRecording()
                          }
                      }) {
                          self.btnIsPressing.toggle()
                          self.btnTitle = "Hold To Speak"
                          self.finishRecording()
                      }
                      .foregroundColor(.black)
                      .font(.system(size: 20, weight: .medium))
                      .background(Color.gray)
                      .padding()
                }
                  .frame(width: proxy.size.width, height: proxy.size.height)
            }
        }.ignoresSafeArea()
    }

    private func startRecording() {
        audioManager.startRecord(saveUrl: audioUrl)
    }

    private func finishRecording() {
        audioManager.stopRecord()
        recognizeVoice(audioUrl: audioUrl)
    }

    private func recognizeVoice(audioUrl: URL) {
//        let locale = Locale(identifier: "nl_NL")
//        SFSpeechRecognizer(locale: locale)
        guard let recognizer = SFSpeechRecognizer(), recognizer.isAvailable else {
            printLog("Speech recognizer not available.")
            return
        }

        let recognitionRequest = SFSpeechURLRecognitionRequest(url: audioUrl)
        recognitionRequest.shouldReportPartialResults = true

        recognizer.recognitionTask(with: recognitionRequest) { (result, error) in
            guard error == nil else {
                printLog(error!.localizedDescription); return
            }
            guard let result = result else {
                return
            }

            print("got a new result: \(result.bestTranscription.formattedString), final : \(result.isFinal)")
            if result.isFinal {
                printLog(result.bestTranscription.formattedString)
                DispatchQueue.main.async {
//                    self.updateUI(withResult: result)
                }
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
