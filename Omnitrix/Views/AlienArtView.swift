import SwiftUI

/// Shows the alien's artwork from the asset catalog (named `alien.artName`),
/// or its SF Symbol if no artwork has been imported.
struct AlienArtView: View {
    let alien: Alien
    /// Tint for the SF Symbol fallback (artwork keeps its own colours).
    var fallbackTint: Color

    var body: some View {
        if let art = UIImage(named: alien.artName) {
            Image(uiImage: art)
                .resizable()
                .scaledToFit()
        } else {
            Image(systemName: alien.symbol)
                .resizable()
                .scaledToFit()
                .foregroundStyle(fallbackTint)
                .padding(4)
        }
    }
}
