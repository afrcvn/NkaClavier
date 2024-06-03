import SwiftUI

struct BlurEffect: UIViewRepresentable {
    //@Environment(\.colorScheme) var colorScheme
    var style : UIBlurEffect.Style
    var effect: Effect?
    
    init(
        style: UIBlurEffect.Style = .systemUltraThinMaterial,
        effect: Effect? = .none
    ) {
        self.style = style
        self.effect = effect
    }
    
    enum Effect {
        case gaussianBlur, removeAll
    }
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        DispatchQueue.main.async {
            if let backdropLayer = uiView.layer.sublayers?.first {
                switch effect {
                case .gaussianBlur:
                    backdropLayer.filters?.removeAll { String(describing: $0) != "gaussianBlur"}
                case .removeAll:
                    backdropLayer.filters = []
                case nil:
                    break
                }
            }
        }
    }
}
