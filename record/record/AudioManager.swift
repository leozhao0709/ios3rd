//
// Created by Lei Zhao on 11/12/20.
//

import Foundation
import AVFoundation

class AudioManager {
    private var audioPlayer: AVAudioPlayer?
    private let session = AVAudioSession.sharedInstance()

    static let sharedInstance = AudioManager()

    private init() {
    }

    public func playAudio(url: URL, onError: ((Error) -> Void)? = nil) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)

            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            self.audioPlayer = audioPlayer
            self.audioPlayer?.play()
        } catch {
            onError?(error)
        }
    }

    public func stopAudio() {
        self.audioPlayer?.stop()
    }
}
