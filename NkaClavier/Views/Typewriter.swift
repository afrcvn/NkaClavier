import SwiftUI

struct Typewriter: View {
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
    init(texts: String..., cursor: Character = "_", speed: TimeInterval = 0.2, delay: TimeInterval = 1.0) {
        self.texts = texts
        self.cursor = String(cursor)
        self.speed = speed
        self.delay = delay
    }
    
    var body: some View {
        Text(AttributedString(currentText) + cursorAttributed)
            .onAppear(perform: startTyping)
            .onDisappear(perform: stopTyping)
    }
    
    private var cursorAttributed: AttributedString {
        var text = AttributedString(cursor)
        text.foregroundColor = showCursor ? .primary : .clear
        return text
    }
    
    private func startTyping() {
        stopTyping() // Ensure no previous timers exist
        
        currentIndex = 0
        charIndex = 0
        currentText = ""
        isDeleting = false
        isPaused = false
        
        // Timer for typing effect
        timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { _ in
            typeOrDeleteCharacter()
        }
        
        // Cursor blinking
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            if !isPaused {
                showCursor.toggle()
            }
        }
    }
    
    private func stopTyping() {
        timer?.invalidate()
        timer = nil
    }
    
    private func typeOrDeleteCharacter() {
        guard currentIndex < texts.count else {
            // Loop back to the first text
            currentIndex = 0
            charIndex = 0
            currentText = ""
            isDeleting = false
            return
        }
        
        let text = texts[currentIndex]
        
        if isPaused { return }
        
        if isDeleting {
            if !currentText.isEmpty {
                currentText.removeLast()
            } else {
                // Move to the next text
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
            } else {
                // Pause before deleting
                isPaused = true
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    self.isDeleting = true
                    self.isPaused = false
                }
            }
        }
    }
}

#Preview {
    Typewriter(texts: "One", "Two", "Three", "Welcome to SwiftUI!", cursor: "⏺")
}
