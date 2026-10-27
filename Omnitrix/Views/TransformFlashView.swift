import SwiftUI

/// The green flash shown while transforming.
struct TransformFlashView: View {
    let color: Color
    @State private var expanded = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Circle()
                .fill(
                    RadialGradient(
                        colors: [.white, .omnitrixGreen, color.opacity(0.6), .clear],
                        center: .center,
                        startRadius: 0,
                        endRadius: 120
                    )
                )
                .scaleEffect(expanded ? 3.0 : 0.05)
                .opacity(expanded ? 1 : 0.6)
        }
        .onAppear {
            withAnimation(.easeIn(duration: 0.6)) { expanded = true }
        }
        .accessibilityLabel("Transforming")
    }
}

#Preview {
    TransformFlashView(color: AlienRoster.all[0].color)
}
