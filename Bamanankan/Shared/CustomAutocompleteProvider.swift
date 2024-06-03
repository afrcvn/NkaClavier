import KeyboardKit
import Foundation

class CustomAutocompleteProvider: AutocompleteProvider {

    init(context: AutocompleteContext, keyboardContext: KeyboardContext = .preview, words: [String]) {
        self.context = context
        
        searchEngine = .init(words: words)
        self.keyboardContext = keyboardContext
    }
    
    private var searchEngine: SearchEngine

    private var context: AutocompleteContext
    
    private var keyboardContext: KeyboardContext

    
    var locale: Locale = .current
    
    var canIgnoreWords: Bool { false }
    var canLearnWords: Bool { false }
    var ignoredWords: [String] = []
    var learnedWords: [String] = []
    
    func hasIgnoredWord(_ word: String) -> Bool { false }
    func hasLearnedWord(_ word: String) -> Bool { true }
    func ignoreWord(_ word: String) {}
    func learnWord(_ word: String) {}
    func removeIgnoredWord(_ word: String) {}
    func unlearnWord(_ word: String) {}
    
    func autocompleteSuggestions(
        for text: String
    ) async throws -> [Autocomplete.Suggestion] {
        guard text.count > 0 else { return [] }
        print(keyboardContext.keyboardType)
        var suggestions: [Autocomplete.Suggestion] = []
        if context.isAutocorrectEnabled, context.isAutocompleteEnabled {
            let matchs = searchEngine.searchClosestMatches(query: text, threshold: 1)
            suggestions = matchs.prefix(3).map { .init(text: textCase(source: text, text: $0.word), isAutocorrect: $0.distance == 0) }
        }
        return suggestions
    }
    
    func textCase(source: String, text: String) -> String {
        switch keyboardContext.preferredKeyboardType {
            case .alphabetic(let type):
                switch type {
                    case .capsLocked:
                        return text.uppercased()
                    default:
                    return source.first?.isUppercase ?? false ? text.capitalized : text
                }
            default:
                return text
        }
    }
}

