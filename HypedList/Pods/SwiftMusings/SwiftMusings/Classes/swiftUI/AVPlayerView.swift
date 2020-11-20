//
// Created by Lei Zhao on 11/12/20.
//

import SwiftUI
import AVKit

public struct AVPlayerView: UIViewControllerRepresentable {

    var player: AVPlayer
    var showsPlaybackControls: Bool

    // if we want to customize control, then we should make following to false
    public init(player: AVPlayer, showsPlaybackControls: Bool = true) {
        self.player = player
        self.showsPlaybackControls = showsPlaybackControls
    }

    public func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
       controller.showsPlaybackControls = showsPlaybackControls
        return controller
    }

    public func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.player = player
    }
}
