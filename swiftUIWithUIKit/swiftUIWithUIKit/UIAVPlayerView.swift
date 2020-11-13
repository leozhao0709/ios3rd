//
// Created by Lei Zhao on 11/12/20.
//

import UIKit
import AVKit

class UIAVPlayerView: UIView {
    private let playerLayer = AVPlayerLayer()

    init(player: AVPlayer) {
        super.init(frame: .zero)

        playerLayer.player = player
        layer.addSublayer(playerLayer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }

    func updatePlayer(player: AVPlayer) {
        self.playerLayer.player = player
    }
}
