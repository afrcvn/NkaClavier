import KeyboardKit

class SoninkeStyleProvider: KeyboardStyle.StandardProvider {
    
    /// Provides the button text for the given action.
    ///
    /// - Parameter action: The keyboard action.
    /// - Returns: The button text for the action.
    override func buttonText(for action: KeyboardAction) -> String? {
        switch action {
        case .space: "soninkaxane"
        case .primary(let type): primaryButtonText(type: type)
        default: super.buttonText(for: action)
        }
    }
    
    /// Provides the button text for primary actions.
    ///
    /// - Parameter type: The primary action type.
    /// - Returns: The button text for the primary action type.
    private func primaryButtonText(type: Keyboard.ReturnKeyType) -> String {
        switch type {
        case .continue: "na daga"
        case .return: "ka sage"
        case .done: "a duguta"
        case .emergencyCall: "Emergency Call"
        case .go: "na daga"
        case .join: "na daga"
        case .newLine: "noone kurumba"
        case .next: "nata"
        case .ok: "ok"
        case .route: "kille"
        case .search: "n‘a mundu"
        case .send: "k‘a xeyi"
        case .custom(title: let title): title
        }
    }
}

