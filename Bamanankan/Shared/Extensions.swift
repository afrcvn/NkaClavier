import SwiftUI
import KeyboardKit

extension Bundle {
    /// Decodes JSON data from a file in the bundle.
    /// - Parameters:
    ///   - filename: The name of the file (excluding extension).
    ///   - withExtension: The file extension. Default is "json".
    /// - Returns: The decoded data of type T.
    /// - Throws: An error if decoding fails.
    public func decode<T: Decodable>(_ filename: String, withExtension: String = "json") throws -> T {
        guard let url = self.url(forResource: filename, withExtension: withExtension) else {
            throw NSError(domain: NSCocoaErrorDomain, code: NSFileReadNoSuchFileError, userInfo: [NSLocalizedDescriptionKey: "Failed to locate \(filename) in bundle."])
        }

        guard let data = try? Data(contentsOf: url) else {
            throw NSError(domain: NSCocoaErrorDomain, code: NSFileReadUnknownError, userInfo: [NSLocalizedDescriptionKey: "Failed to load \(filename) from bundle."])
        }

        let decoder = JSONDecoder()

        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            let nsError = error as NSError
            throw NSError(domain: nsError.domain, code: nsError.code, userInfo: [NSLocalizedDescriptionKey: "Failed to decode \(filename) with error: \(nsError.localizedDescription)"])
        }
    }
}

extension KeyboardLayout {
    func insert(_ char: Character, after item: Character) {
        let lower = tryCreateBottomRowItem(for: .character(String(char)), size: .init(width: .input, height: idealItemHeight))
        let upper = tryCreateBottomRowItem(for: .character(String(char).capitalized), size: .init(width: .input, height: idealItemHeight))
        if let lower {
            itemRows.insert(lower, after: .character(String(item)))
        }
        if let upper {
            itemRows.insert(upper, after: .character(String(item).capitalized))
        }
    }
    
    func insert(_ char: Character, after item: KeyboardAction) {
        let lower = tryCreateBottomRowItem(for: .character(String(char)), size: .init(width: .input, height: idealItemHeight))
        let upper = tryCreateBottomRowItem(for: .character(String(char).capitalized), size: .init(width: .input, height: idealItemHeight))
        if let lower {
            itemRows.insert(lower, after: item)
        }
        if let upper, upper != lower {
            itemRows.insert(upper, after: item)
        }
    }
    
    func insert(_ char: Character, before item: Character) {
        let lower = tryCreateBottomRowItem(for: .character(String(char)), size: .init(width: .input, height: idealItemHeight))
        let upper = tryCreateBottomRowItem(for: .character(String(char).capitalized), size: .init(width: .input, height: idealItemHeight))
        if let lower {
            itemRows.insert(lower, before: .character(String(item)))
        }
        if let upper {
            itemRows.insert(upper, before: .character(String(item).capitalized))
        }
    }
    
    func insert(_ char: Character, before item: KeyboardAction) {
        let lower = tryCreateBottomRowItem(for: .character(String(char)), size: .init(width: .input, height: idealItemHeight))
        let upper = tryCreateBottomRowItem(for: .character(String(char).capitalized), size: .init(width: .input, height: idealItemHeight))
        if let lower {
            itemRows.insert(lower, before: item)
        }
        if let upper, lower != upper {
            itemRows.insert(upper, before: item)
        }
    }
    
    func insert(_ newAction: KeyboardAction, before action: KeyboardAction) {
        if let new = tryCreateBottomRowItem(for: action, size: .init(width: .input, height: idealItemHeight)) {
            itemRows.insert(new, before: action)
        }
    }

    func replace(_ char: String, with newItem: String) {
        if let item = itemRows.flatMap({ $0 }).first(where: { $0.rowId == .character(char) }) {
            itemRows.replace(item, with: .init(action: .character(newItem), size: item.size, edgeInsets: item.edgeInsets))
        } else if let item = itemRows.flatMap({ $0 }).first(where: { $0.rowId == .character(char.capitalized) }){
            itemRows.replace(item, with: .init(action: .character(newItem.capitalized), size: item.size, edgeInsets: item.edgeInsets))
        }
    }
    
    func replace(action: KeyboardAction, with newItem: String) {
        if let item = itemRows.flatMap({ $0 }).first(where: { $0.action.image ==  action.image}) {
            itemRows.replace(item, with: .init(action: .character(newItem), size: item.size, edgeInsets: item.edgeInsets))
        }
    }

}
