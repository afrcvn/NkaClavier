import SwiftUI
import AVKit

struct VideoPlayerView: UIViewRepresentable {
    @State var player: AVPlayer
    
    func makeUIView(context: Context) -> UIView {
        let view = PlayerUIView(player: player)
        NotificationCenter.default.addObserver(
            context.coordinator,
            selector: #selector(Coordinator.playerDidFinishPlaying),
            name: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem
        )
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        self.player = player
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(player: player)
    }

    class PlayerUIView: UIView {
        private let playerLayer = AVPlayerLayer()
        
        init(player: AVPlayer) {
            super.init(frame: .zero)
            playerLayer.player = player
            playerLayer.videoGravity = .resizeAspectFill
            layer.addSublayer(playerLayer)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            playerLayer.frame = bounds
        }
    }
    
    class Coordinator: NSObject {
        let player: AVPlayer

        init(player: AVPlayer) {
            self.player = player
        }

        @objc func playerDidFinishPlaying() {
            player.seek(to: .zero)
            player.play()
        }
    }
}
