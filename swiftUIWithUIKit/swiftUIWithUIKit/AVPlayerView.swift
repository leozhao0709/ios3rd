//
// Created by Lei Zhao on 11/12/20.
//

import SwiftUI
import AVKit
import Combine

struct AVPlayerView: UIViewControllerRepresentable {

    var player: AVPlayer?

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player

        // if we want to customize control, then we should make following to false
//        controller.showsPlaybackControls = false
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.player = player
    }
}
