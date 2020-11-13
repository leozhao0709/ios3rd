//
// Created by Lei Zhao on 11/12/20.
//

import SwiftUI
import AVFoundation
import AVKit

struct AVPlayerView: UIViewRepresentable {

    var mediaUrl: URL

    func makeUIView(context: Context) -> UIView {
        let playerController = AVPlayerViewController()
        playerController.player = AVPlayer(url: mediaUrl)
        playerController.view.frame = CGRect(x: 10, y: 100, width: 400, height: 400)
        playerController.player?.play()
        return playerController.view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
