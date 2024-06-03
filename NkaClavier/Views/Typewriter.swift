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
#Preview {
    Typewriter(text: "Bonjour Bahsamba Diawara")
}
