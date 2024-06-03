import Foundation

class TrieNode {
    var children: [Character: TrieNode] = [:]
    var isEndOfWord: Bool = false
}

class Trie {
    let root = TrieNode()

    func insert(_ word: String) {
        var currentNode = root
        for char in word {
            if let childNode = currentNode.children[char] {
                currentNode = childNode
            } else {
                let newNode = TrieNode()
                currentNode.children[char] = newNode
                currentNode = newNode
            }
        }
        currentNode.isEndOfWord = true
    }

    func search(_ word: String) -> Bool {
        var currentNode = root
        for char in word {
            if let childNode = currentNode.children[char] {
                currentNode = childNode
            } else {
                return false
            }
        }
        return currentNode.isEndOfWord
    }

    func startsWith(_ prefix: String) -> Bool {
        var currentNode = root
        for char in prefix {
            if let childNode = currentNode.children[char] {
                currentNode = childNode
            } else {
                return false
            }
        }
        return true
    }
}

class SearchEngine {
    let trie = Trie()
    var words: Set<String>

    init(words: some Collection<String>) {
        self.words = .init(words.map(\.localizedLowercase))
        buildTrie()
    }

    private func buildTrie() {
        for word in words {
            trie.insert(word.lowercased()) // Insert lowercase word into the trie
        }
    }

    func search(query: String) -> String? {
        let lowercaseQuery = query.lowercased() // Convert query to lowercase
        var minDistance = Int.max
        var closestMatch: String?

        for word in words {
            let distance = levenshteinDistance(query: lowercaseQuery, word: word.lowercased()) // Compare lowercase word
            if distance < minDistance {
                minDistance = distance
                closestMatch = word
            }
        }

        return closestMatch
    }

    func searchClosestMatches(query: String, threshold: Int) -> [MatchItem] {
        let lowercaseQuery = query.lowercased() // Convert query to lowercase
        var closestMatches: [MatchItem] = []

        for word in words {
            let distance = levenshteinDistance(query: lowercaseQuery, word: word.lowercased()) // Compare lowercase word
            if distance <= threshold {
                closestMatches.append(.init(word: word, distance: distance))
            }
        }
        closestMatches = Set(closestMatches).sorted { $0.distance < $1.distance }
        
        return closestMatches
    }
    
    
    struct MatchItem: Hashable {
        let word: String
        let distance: Int
    }

    private func levenshteinDistance(query: String, word: String) -> Int {
        let m = query.count
        let n = word.count
        var distances = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)

        for i in 0...m {
            distances[i][0] = i
        }

        for j in 0...n {
            distances[0][j] = j
        }

        for (i, queryChar) in query.enumerated() {
            for (j, wordChar) in word.enumerated() {
                let cost = queryChar == wordChar ? 0 : 1
                distances[i + 1][j + 1] = Swift.min(
                    distances[i][j + 1] + 1,
                    distances[i + 1][j] + 1,
                    distances[i][j] + cost
                )
            }
        }

        return distances[m][n]
    }
}
