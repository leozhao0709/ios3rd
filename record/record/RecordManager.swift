//
// Created by Lei Zhao on 11/12/20.
//

import Foundation
import AVFoundation

class RecordManager {

    static let sharedInstance = RecordManager();

    private var recorder: AVAudioRecorder?

    private init() {
    }

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
