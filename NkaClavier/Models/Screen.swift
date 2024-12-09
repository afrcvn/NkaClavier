import AVFoundation

enum Screen: Int, CaseIterable, Hashable, Identifiable {
    case first, seconde, thirsd, fourth
    var id: Self { self }
}
