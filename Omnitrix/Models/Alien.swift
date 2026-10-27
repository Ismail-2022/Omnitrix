import SwiftUI

/// One transformation available on the Omnitrix.
struct Alien: Identifiable, Equatable {
    /// Position in the crown scroll order (0-based).
    let id: Int
    let name: String
    let species: String
    /// Nil when the homeworld isn't recorded; the UI hides the row.
    let homeworld: String?
    let power: String
    /// SF Symbol used as the alien's silhouette (no official artwork in this repo).
    let symbol: String
    /// Signature colour, as 0xRRGGBB.
    let colorHex: UInt32

    var color: Color { Color(hex: colorHex) }
}

extension Color {
    init(hex: UInt32) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255
        )
    }

    static let omnitrixGreen = Color(hex: 0x39FF14)
}
