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
        case .continue: "ka taa fɛ"
        case .return: "ka segin"
        case .done: "a kɛra"
        case .emergencyCall: "Emergency Call"
        case .go: "ka taa"
        case .join: "k‘a sɛgɛrɛ"
        case .newLine: "line kura"
        case .next: "nata"
        case .ok: "ka sɔn"
        case .route: "sira"
        case .search: "k‘a ɲini"
        case .send: "k‘a ci"
        case .custom(title: let title): title
        }
    }
}

