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
    @State var sayingMessage: String?
    let audioManager = AudioManager.shared
    let audioUrl = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents/record.m4a")
    @State var gameOver = false
    @State var guessingNum = (1...100).randomElement()!
    @State var showGameOver = false
    @State var hintText = ""
    @State var useChinese = false

    var body: some View {
        ZStack {
            GeometryReader { (proxy: GeometryProxy) in
                Image("bg")
                  .resizable()
                  .scaledToFill()

                VStack {
                    Image("mic")
                        .padding(35)
                    Toggle(isOn: $useChinese) {
                        Text("Use Chinese")
                            .foregroundColor(.white)
                            .font(.title2)
                    }.fixedSize()
                    Text("Guess a Number Between\n1 - 100")
                      .multilineTextAlignment(.center)
                      .font(.largeTitle)
                      .foregroundColor(.white)
                    Button(btnTitle) {
                        self.btnIsPressing.toggle()
                        self.btnTitle = "Hold To Speak"
                        self.finishRecording()
                    }
                      .padding()
                      .onLongPressGesture(pressing: { isPressing in
                          if isPressing {
                              self.btnIsPressing.toggle()
                              self.startRecording()
                          }
                      }) {
                      }
                      .foregroundColor(.black)
                      .font(.system(size: 20, weight: .medium))
                      .background(Color.gray)
                      .padding()
                    if let message = self.sayingMessage {
                        VStack(spacing: 20) {
                            Text("You said:")
                            Text(message)
                              .padding()
                              .border(Color.gray, width: 2)
                            Text(hintText)
                                .multilineTextAlignment(.center)
                        }
                          .font(.title)
                          .foregroundColor(.white)
                    }
                }
                  .frame(width: proxy.size.width, height: proxy.size.height)
            }
              .alert(isPresented: $showGameOver) {
                  Alert(
                    title: Text("You Got it"),
                    message: Text("The guessing number is \(self.guessingNum)"),
                    dismissButton: .default(Text("Play Again")) {
                        self.guessingNum = (1...100).randomElement()!
                        self.showGameOver = false
                        self.sayingMessage = nil
                    }
                  )
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
        var recognizer: SFSpeechRecognizer?
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut
        if useChinese {
            let locale = Locale(identifier: "zh")
            numberFormatter.locale = locale
            recognizer = SFSpeechRecognizer(locale: locale)
        } else {
            recognizer = SFSpeechRecognizer()
        }

        guard let speechRecognizer = recognizer , speechRecognizer.isAvailable else {
            printLog("Speech recognizer not available.")
            return
        }

        let recognitionRequest = SFSpeechURLRecognitionRequest(url: audioUrl)
        recognitionRequest.shouldReportPartialResults = true

        speechRecognizer.recognitionTask(with: recognitionRequest) { (result, error) in
            guard error == nil else {
                printLog(error!.localizedDescription); return
            }
            guard let result = result else {
                return
            }

            print("got a new result: \(result.bestTranscription.formattedString), final : \(result.isFinal)")
            if result.isFinal {
                DispatchQueue.main.async {
                    let formattedString = result.bestTranscription.formattedString
                    let message = numberFormatter.number(from: formattedString.lowercased())?.stringValue
                    self.sayingMessage = message ?? formattedString

                    guard
                      let customMessage = self.sayingMessage,
                      let customerGuessNumer = Int(customMessage),
                          (1...100).contains(customerGuessNumer)
                      else {
                        self.hintText = "Please give a number\n between 1 to 100"
                        return
                    }

                    if (customerGuessNumer < guessingNum) {
                        self.hintText = "GO HIGHER"
                    } else if(customerGuessNumer > guessingNum) {
                        self.hintText = "GO LOWER"
                    } else {
                        self.hintText = "YOU GOT IT"
                        self.showGameOver = true
                    }
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
