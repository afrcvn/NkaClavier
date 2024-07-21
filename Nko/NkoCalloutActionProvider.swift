import KeyboardKit

/// Provides callout actions for the Bambara keyboard.
class NkoCalloutActionProvider: Callouts.BaseActionProvider {
    override func calloutActions(for action: KeyboardAction) -> [KeyboardAction] {
        switch action {
        case .toneMark:  [Character].toneMarks.map { .character(String($0)) }
        case .tonalApostrophes:  ["ߴ", "ߵ"].map { KeyboardAction.character($0) }
        case .character("ߙ"):  ["ߙ", "ߚ"].map { KeyboardAction.character($0) }
        case .character("ߨ"): ["ߨ", "ߩ", "ߪ"].map { KeyboardAction.character($0) }
        default: super.calloutActions(for: action)
        }
    }
}
