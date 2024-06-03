import KeyboardKit

class SoninkeLayoutProvider: KeyboardLayout.StandardProvider {
    
    /// Generates the keyboard layout for the given context.
    ///
    /// - Parameter context: The context in which the keyboard is displayed.
    /// - Returns: The generated keyboard layout.
    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let layout = super.keyboardLayout(for: context)
                
        // Replace characters with their Bambara equivalents
        layout.replace("z", with: "ŋ")
        layout.replace("v", with: "ɲ")
        layout.insert("‘", after: "l")

        return layout
    }
}
