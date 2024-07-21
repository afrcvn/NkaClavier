import KeyboardKit

class NkoLayoutProvider: KeyboardLayout.iPhoneProvider {
    
    override init(alphabeticInputSet: InputSet = .nkoChar, numericInputSet: InputSet = .nkoNumber(currency: "$"), symbolicInputSet: InputSet = .nkoSymbolic(currencies: [])) {
        super.init(alphabeticInputSet: alphabeticInputSet, numericInputSet: numericInputSet, symbolicInputSet: symbolicInputSet)
    }
    
    override func keyboardSwitchActionForBottomInputRow(for context: KeyboardContext) -> KeyboardAction? {
        switch context.keyboardType {
        case .alphabetic(_): 

            return nil
        default:  return super.keyboardSwitchActionForBottomInputRow(for: context)
        }
    }
    
    override func bottomActions(for context: KeyboardContext
) -> KeyboardAction.Row {
        var result = KeyboardAction.Row()
        let needsInputSwitch = context.needsInputModeSwitchKey
        let needsDictation = context.needsInputModeSwitchKey
        if let action = keyboardSwitchActionForBottomRow(for: context) { result.append(action) }
        if needsInputSwitch { result.append(.nextKeyboard) }
        if !needsInputSwitch { result.append(.keyboardType(.emojis)) }
        let dictationReplacement = context.keyboardDictationReplacement
        if context.interfaceOrientation.isPortrait, needsDictation, let action = dictationReplacement { result.append(action) }
        
        if context.keyboardType.isAlphabetic {
            result.append(.character("ߨ"))
        }
        
        result.append(.space)
        
        
        
        #if os(iOS) || os(tvOS) || os(visionOS)
        if context.textDocumentProxy.keyboardType == .emailAddress {
            result.append(.character("@"))
            result.append(.character("."))
        }
        if context.textDocumentProxy.returnKeyType == .go {
            result.append(.character("."))
        }
        #endif
        if context.keyboardType.isAlphabetic {
            result.append(.toneMark)
        }
        
        result.append(keyboardReturnAction(for: context))
        if !context.interfaceOrientation.isPortrait, needsDictation, let action = dictationReplacement { result.append(action) }
        return result
    }
        
    override func itemSizeWidth(for action: KeyboardAction, row: Int, index: Int, context: KeyboardContext) -> KeyboardLayout.ItemWidth {
        switch action {
//        case .backspace:
//            switch context.keyboardType {
//            case .alphabetic(_): .input
//            default: super.itemSizeWidth(for: action, row: row, index: index, context: context)
//            }
        case .keyboardType(_):
            row == 3 ? super.itemSizeWidth(for: .primary(.done), row: row, index: index, context: context) : super.itemSizeWidth(for: action, row: row, index: index, context: context)
        default: super.itemSizeWidth(for: action, row: row, index: index, context: context)
        }
    }
}

extension [Character] {
    static let toneMarks: Self = ["߫", "߬", "߰", "߮", "߱", "߯", "߭","߳", "߲"]
}
