import KeyboardKit
import SwiftUI

class NkoStyleProvider: KeyboardStyle.StandardProvider {
    
    /// Provides the button text for the given action.
    ///
    /// - Parameter action: The keyboard action.
    /// - Returns: The button text for the action.
    override func buttonText(for action: KeyboardAction) -> String? {
        switch action {
        case .space: nil
        case .keyboardType(let type):
            switch type {
            case .alphabetic(let `case`):
                "ߒߞߏ"
            case .numeric:
                "߁߂߃"
            default: super.buttonText(for: action)
            }
        case .primary(let type): nil
        default: super.buttonText(for: action)
        }
    }
    
    override func buttonImage(for action: KeyboardAction) -> Image? {
        switch action {
        case .primary(let type):
            Image(systemName: primaryButtonSystemImage(type: type))
        case .space: Image(systemName: "space")
        default: super.buttonImage(for: action)
        }
        
    }
    
    /// Provides the button text for primary actions.
    ///
    /// - Parameter type: The primary action type.
    /// - Returns: The button text for the primary action type.
    private func primaryButtonSystemImage(type: Keyboard.ReturnKeyType) -> String {
        switch type {
        case .continue: "arrow.right"
        case .return: "return.left"
        case .done: "return.left"
        case .emergencyCall: ""
        case .go: "return.left"
        case .join: "return.left"
        case .newLine: "return.left"
        case .next: "return.left"
        case .ok: "return.left"
        case .route: "return.left"
        case .search: "magnifyingglass"
        case .send: "paperplane"
        case .custom(title: let title): title
        }
    }
}

