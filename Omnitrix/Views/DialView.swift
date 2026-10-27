import SwiftUI

/// The Omnitrix face, edge to edge: a green hourglass running from the screen
/// corners to the centre, and a glowing core showing the selected alien.
struct DialView: View {
    let alien: Alien
    let total: Int

    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            let core = min(w, h) * 0.68

            ZStack {
                Color.black

                HourglassShape()
                    .fill(
                        LinearGradient(
                            colors: [Color.omnitrixGreen, Color(hex: 0x1FA80F), Color.omnitrixGreen],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )

                // Core window
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [Color(hex: 0xC8FFB8), Color.omnitrixGreen, Color(hex: 0x1FA80F)],
                            center: .center,
                            startRadius: 0,
                            endRadius: core / 2
                        )
                    )
                    .overlay(Circle().strokeBorder(.black, lineWidth: core * 0.04))
                    .frame(width: core, height: core)
                    .shadow(color: .omnitrixGreen.opacity(0.9), radius: 12)

                VStack(spacing: core * 0.02) {
                    AlienArtView(alien: alien, fallbackTint: .black)
                        .frame(width: core * 0.58, height: core * 0.58)
                        .id(alien.id)
                        .transition(.scale(scale: 0.4).combined(with: .opacity))

                    Text(alien.name.uppercased())
                        .font(.system(size: core * 0.1, weight: .heavy, design: .rounded))
                        .foregroundStyle(.black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .frame(maxWidth: core * 0.8)
                }
                .frame(width: core, height: core)

                Text("\(alien.id + 1) / \(total)")
                    .font(.system(size: 13, weight: .bold, design: .rounded).monospacedDigit())
                    .foregroundStyle(.black.opacity(0.75))
                    .position(x: w / 2, y: h - 12)
            }
            .frame(width: w, height: h)
        }
        .ignoresSafeArea()
        .contentShape(Rectangle())
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Omnitrix dial, \(alien.name) selected")
        .accessibilityHint("Turn the Digital Crown to choose an alien. Double tap to transform.")
    }
}

/// Two triangles meeting at the centre: the dial's hourglass.
struct HourglassShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        path.closeSubpath()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    DialView(alien: AlienRoster.all[0], total: AlienRoster.all.count)
}
