import KeyboardKit

/// Provides callout actions for the Bambara keyboard.
class BambaraCalloutActionProvider: Callouts.BaseActionProvider {
    
    /// Provides the callout action string for the given character.
    ///
    /// - Parameter char: The character.
    /// - Returns: The callout action string.
    override func calloutActionString(for char: String) -> String {
        switch char {
        case "ɔ": "ɔ̄ɔ̱ɔ̃ɔ̈ɔ̨ɔ̧ɔ̌ɔ̂ɔ̀ɔ́"
        case "ɔ".capitalized: "ɔ̄ɔ̱ɔ̃ɔ̈ɔ̨ɔ̧ɔ̌ɔ̂ɔ̀ɔ́".uppercased()
        default: super.calloutActionString(for: char)
        }
    }
}
