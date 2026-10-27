import SwiftUI

/// Shown after transforming: who you turned into and what they can do.
struct AlienDetailView: View {
    let alien: Alien
    let onRevert: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                AlienArtView(alien: alien, fallbackTint: alien.color)
                    .frame(height: 110)
                    .frame(maxWidth: .infinity)
                    .shadow(color: alien.color.opacity(0.6), radius: 10)

                Text(alien.name)
                    .font(.title3.bold())
                    .lineLimit(2)
                    .minimumScaleFactor(0.7)
                    .frame(maxWidth: .infinity)

                InfoRow(label: "Species", value: alien.species)
                if let homeworld = alien.homeworld {
                    InfoRow(label: "Homeworld", value: homeworld)
                }
                InfoRow(label: "Power", value: alien.power)

                Button(action: onRevert) {
                    Label("Revert", systemImage: "arrow.uturn.backward")
                        .frame(maxWidth: .infinity)
                }
                .tint(.omnitrixGreen)
                .padding(.top, 4)
            }
            .padding(.horizontal, 4)
        }
        .background(
            LinearGradient(
                colors: [alien.color.opacity(0.35), .black],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
}

private struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(label.uppercased())
                .font(.caption2)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.footnote)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    AlienDetailView(alien: AlienRoster.all[5], onRevert: {})
}
