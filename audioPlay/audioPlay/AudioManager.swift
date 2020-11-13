//
// Created by Lei Zhao on 11/13/20.
//

import Foundation
import AVFoundation
import UIKit
import AudioToolbox

class AudioManager {
    private var audioPlayer: AVAudioPlayer?
    private let session = AVAudioSession.sharedInstance()

    static let sharedInstance = AudioManager()

    private init() {
    }

    public func playAudio(url: URL, onError: ((Error) -> Void)? = nil) {
        do {
            // we need this line to show the high volume
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

    public func playVibrateSound(onError: ((Error) -> Void)? = nil) {
        let deviceModel = UIDevice.current.model
        if deviceModel == "iPhone" {
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        } else {
            onError?(DeviceNotSupportError(description: "\(deviceModel) not support vibrate sound"))
        }
    }

    public func playSystemSound(
      url: URL? = Bundle(identifier: "com.apple.UIKit")?.url(forResource: "Tock", withExtension: "aiff"),
      onComplete: (() -> Void)? = nil
    ) {
        let soundId: SystemSoundID
        AudioServicesCreateSystemSoundID(url, soundId)
        AudioServicesAddSystemSoundCompletion(soundId, nil, nil, { id, pointer in
            AudioServicesRemoveSystemSoundCompletion(id)
            AudioServicesDisposeSystemSoundID(id)
        }, nil)

        AudioServicesPlayAlertSoundWithCompletion(soundId, onComplete)
    }
}

extension AudioManager {
    struct DeviceNotSupportError: LocalizedError {
        var errorDescription: String? {
            _description
        }
        var failureReason: String? {
            _description
        }

        private var _description: String

        init(description: String) {
            self._description = description
        }
    }
}
