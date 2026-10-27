import SwiftUI

/// The Omnitrix face: a dark dial with a glowing hourglass and the
/// currently selected alien's silhouette in the core.
struct DialView: View {
    let alien: Alien
    let total: Int

    var body: some View {
        VStack(spacing: 4) {
            GeometryReader { geo in
                let size = min(geo.size.width, geo.size.height)
                ZStack {
                    // Outer bezel
                    Circle()
                        .fill(Color(white: 0.18))
                    Circle()
                        .strokeBorder(alien.color.opacity(0.6), lineWidth: size * 0.025)
                        .shadow(color: alien.color.opacity(0.7), radius: 6)

                    // Face with hourglass
                    Circle()
                        .fill(.black)
                        .padding(size * 0.06)
                    HourglassShape()
                        .fill(Color.omnitrixGreen.opacity(0.85))
                        .padding(size * 0.06)
                        .clipShape(Circle().inset(by: size * 0.06))

                    // Core window showing the selected alien
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [Color.omnitrixGreen, Color.omnitrixGreen.opacity(0.55)],
                                center: .center,
                                startRadius: 0,
                                endRadius: size * 0.3
                            )
                        )
                        .frame(width: size * 0.56, height: size * 0.56)
                        .shadow(color: .omnitrixGreen.opacity(0.8), radius: 8)

                    Image(systemName: alien.symbol)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.black)
                        .frame(width: size * 0.3, height: size * 0.3)
                        .id(alien.id)
                        .transition(.scale(scale: 0.4).combined(with: .opacity))
                }
                .frame(width: size, height: size)
                .position(x: geo.size.width / 2, y: geo.size.height / 2)
            }

            Text(alien.name)
                .font(.headline)
                .foregroundStyle(alien.color)
                .lineLimit(1)
                .minimumScaleFactor(0.6)
                .id("name-\(alien.id)")

            Text("\(alien.id + 1) / \(total)")
                .font(.caption2.monospacedDigit())
                .foregroundStyle(.secondary)
        }
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
