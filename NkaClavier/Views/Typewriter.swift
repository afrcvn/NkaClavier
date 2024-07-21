import SwiftUI
import AudioToolbox

struct Typewriter: View {
    private var text: String
    @State private var currentText: String = ""
    @State private var timer: Timer?
    @State private var index = 0
    @State private var showCursor = true
    private let cursor: String
    private let speed: TimeInterval
    
    init(text: String, cursor: Character = "_", speed: TimeInterval = 0.2) {
        self.text = text
        self.cursor = String(cursor)
        self.speed = speed
    }

    var body: some View {
        Text(AttributedString(currentText) + cursorAttributed)
            .onAppear(perform: startTyping)
    }
    
    var cursorAttributed: AttributedString {
        var text = AttributedString(cursor)
        text.foregroundColor = showCursor ? .primary : .clear
        return text
    }

    func startTyping() {
        timer?.invalidate()
        index = 0
        currentText = ""
        
        // Timer for typing effect
        timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { _ in
            if index < text.count {
                let nextIndex = text.index(currentText.startIndex, offsetBy: index)
                currentText.append(text[nextIndex])
                index += 1
                AudioServicesPlaySystemSound(1104)
            } else {
                timer?.invalidate()
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
            showCursor.toggle()
        }
    }
}

struct Typewriter2: View {
    private var texts: [String]
    @State private var currentText: String = ""
    @State private var currentIndex: Int = 0
    @State private var charIndex: Int = 0
    @State private var timer: Timer?
    @State private var showCursor = true
    @State private var isDeleting = false
    @State private var isPaused = false
    private let cursor: String
    private let speed: TimeInterval
    private let delay: TimeInterval
    
    init(texts: [String], cursor: Character = "_", speed: TimeInterval = 0.2, delay: TimeInterval = 1.0) {
        self.texts = texts
        self.cursor = String(cursor)
        self.speed = speed
        self.delay = delay
    }

    var body: some View {
        Text(AttributedString(currentText) + cursorAttributed)
            .onAppear(perform: startTyping)
    }
    
    var cursorAttributed: AttributedString {
        var text = AttributedString(cursor)
        text.foregroundColor = showCursor ? .primary : .clear
        return text
    }

    func startTyping() {
        timer?.invalidate()
        currentIndex = 0
        charIndex = 0
        currentText = ""
        isDeleting = false
        isPaused = false
        
        // Timer for typing effect
        timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { _ in
            typeOrDeleteCharacter()
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
            if !isPaused {
                showCursor.toggle()
            }
        }
    }

    func typeOrDeleteCharacter() {
        guard currentIndex < texts.count else {
            currentIndex = 0
            charIndex = 0
            currentText = ""
            isDeleting = false
            return
        }
        
        let text = texts[currentIndex]
        
        if isPaused {
            return
        }
        
        if isDeleting {
            if !currentText.isEmpty {
                currentText.removeLast()
                //AudioServicesPlaySystemSound(1104)
            } else {
                // Move to the next text in the list
                currentIndex += 1
                isDeleting = false
                charIndex = 0
                isPaused = false
                showCursor = true
            }
        } else {
            if charIndex < text.count {
                let nextIndex = text.index(text.startIndex, offsetBy: charIndex)
                currentText.append(text[nextIndex])
                charIndex += 1
                //AudioServicesPlaySystemSound(1104)
            } else {
                // Start deleting after a delay
                isPaused = true
                showCursor = false
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    self.isDeleting = true
                    self.isPaused = false
                }
            }
        }
    }
}

#Preview {
    Typewriter(text: "Bonjour Bahsamba Diawara")
}
