//
// Created by Lei Zhao on 11/13/20.
//

import Foundation
import AVFoundation
import UIKit
import AudioToolbox

class AudioManager: NSObject {
    private var audioPlayer: AVAudioPlayer?
    private var audioPlayerDelegate: AudioPlayerDelegate?
    private var recorder: AVAudioRecorder?
    private let session = AVAudioSession.sharedInstance()
    private var audioPlayerUnmutedVolume: Float?

    static let sharedInstance = AudioManager()

    private override init() {
    }

    public func startNewAudio(
      url: URL,
      onFinishingPlaying: ((_ successfully: Bool) -> Void)? = nil,
      onError: ((Error) -> Void)? = nil) {
        do {
            if let audioPlayer = self.audioPlayer {
                audioPlayer.stop()
            }

            // we need this line to show the high volume
            try AVAudioSession.sharedInstance().setCategory(.playback)

            let audioPlayer = try AVAudioPlayer(contentsOf: url)

            self.audioPlayerDelegate = AudioPlayerDelegate()
            self.audioPlayerDelegate?.onFinishingPlaying = onFinishingPlaying
            audioPlayer.delegate = self.audioPlayerDelegate

            self.audioPlayer = audioPlayer

            if let audioPlayerUnmutedVolume = self.audioPlayerUnmutedVolume {
                self.setAudioVolume(volume: audioPlayerUnmutedVolume)
            } else {
                self.audioPlayerUnmutedVolume = self.audioPlayer?.volume
            }

//            self.audioPlayer?.isMeteringEnabled = true

            self.audioPlayer?.play()
        } catch {
            onError?(error)
        }
    }

    public func audioIsPlaying() -> Bool? {
        self.audioPlayer?.isPlaying
    }

    public func pauseAudio() {
        self.audioPlayer?.pause()
    }

    public func resumeAudio() {
        self.audioPlayer?.play()
    }

    public func stopAudio() {
        self.audioPlayer?.stop()
    }

    public func muteAudio() {
        self.audioPlayer?.volume = 0
    }

    public func unmuteAudio() {
        self.audioPlayer?.volume = audioPlayerUnmutedVolume ?? 0
    }

    public func audioIsMuted() -> Bool {
        self.audioPlayer?.volume == 0 && self.audioPlayerUnmutedVolume != 0
    }

    public func setAudioVolume(volume: Float) {
        self.audioPlayer?.volume = volume
        self.audioPlayerUnmutedVolume = volume
    }

    public func getAudioDuration() -> TimeInterval {
        self.audioPlayer?.duration ?? 0
    }

    public func setAudioPlayTime(timeInterval: TimeInterval) {
        self.audioPlayer?.pause()
        self.audioPlayer?.currentTime = timeInterval
        self.audioPlayer?.play()
    }

    public func setAudioPlayerLoop(num: Int) {
        print("...set Loop...", num)
        self.audioPlayer?.numberOfLoops = num
    }

    public func playVibrateSound(onError: ((Error) -> Void)? = nil) {
        let deviceModel = UIDevice.current.model
        if deviceModel == "iPhone" {
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        } else {
            onError?(DeviceNotSupportError(description: "\(deviceModel) not support vibrate sound"))
        }
    }

    public func getAudioInfo(url: URL) -> [String: String] {
        var audioFileID: AudioFileID?
        AudioFileOpenURL(url as CFURL, .readPermission, 0, &audioFileID)
        var size: UInt32 = 0
        AudioFileGetPropertyInfo(audioFileID!, kAudioFilePropertyInfoDictionary, &size, .none)

        var dictionary: CFDictionary?
        AudioFileGetProperty(audioFileID!, kAudioFilePropertyInfoDictionary, &size, &dictionary)


        return dictionary as! [String: String]
    }

    // sound id can be found here: http://iphonedevwiki.net/index.php/AudioServices or https://github.com/TUNER88/iOSSystemSoundsLibrary
    public func playSystemSound(
      soundId: UInt32? = 1104,
      onComplete: (() -> Void)? = nil
    ) {
        AudioServicesPlayAlertSoundWithCompletion(soundId!, onComplete)
    }

    // sound id can be found here: http://iphonedevwiki.net/index.php/AudioServices or https://github.com/TUNER88/iOSSystemSoundsLibrary
    public func playSystemAlertSound(
      soundId: UInt32? = 1104,
      onComplete: (() -> Void)? = nil) {
        AudioServicesPlaySystemSoundWithCompletion(soundId!, onComplete)
    }
}

// record
extension AudioManager {

    public func startRecord(
      saveUrl: URL = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents/record.m4a"),
      onError: ((Error) -> Void)? = nil,
      AVSampleRate: Int = 44100,
      AVFormatID: UInt32 = kAudioFormatMPEG4AAC,
      AVNumberOfChannels: Int = 1,
      AVEncoderAudioQuality: AVAudioQuality = AVAudioQuality.high
    ) {

        do {

            try AVAudioSession.sharedInstance().setCategory(.playAndRecord)
            try AVAudioSession.sharedInstance().setActive(true)

            let settings: [String: Any] = [
                AVSampleRateKey: AVSampleRate,
                AVFormatIDKey: AVFormatID,
                AVNumberOfChannelsKey: AVNumberOfChannels,
                AVEncoderAudioQualityKey: AVEncoderAudioQuality.rawValue
            ]
            let recorder = try AVAudioRecorder(url: saveUrl, settings: settings)
            self.recorder = recorder
            recorder.record()
        } catch {
            onError?(error)
        }
    }

    public func stopRecord() {
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        self.recorder?.stop()
    }
}

// custom type
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

    class AudioPlayerDelegate: NSObject, AVAudioPlayerDelegate {

        var onFinishingPlaying: ((_ flag: Bool) -> Void)?

        func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
            print("...audioPlayerDidFinishPlaying...")
            onFinishingPlaying?(flag)
        }

        func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        }

        func audioPlayerBeginInterruption(_ player: AVAudioPlayer) {
        }

        func audioPlayerEndInterruption(_ player: AVAudioPlayer, withOptions flags: Int) {
        }
    }
}
