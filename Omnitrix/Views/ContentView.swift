import SwiftUI
import WatchKit

enum OmnitrixPhase {
    case selecting
    case transforming
    case transformed
}

struct ContentView: View {
    @State private var crownValue: Double = 0
    @State private var phase: OmnitrixPhase = .selecting
    @FocusState private var dialFocused: Bool

    private var selected: Alien { AlienRoster.alien(forCrownValue: crownValue) }

    var body: some View {
        ZStack {
            switch phase {
            case .selecting:
                DialView(alien: selected, total: AlienRoster.all.count)
                    .focusable()
                    .focused($dialFocused)
                    .digitalCrownRotation(
                        $crownValue,
                        from: 0,
                        through: Double(AlienRoster.all.count - 1),
                        by: 1,
                        sensitivity: .low,
                        isContinuous: true,
                        isHapticFeedbackEnabled: true
                    )
                    .onTapGesture(perform: transform)
                    .onAppear { dialFocused = true }
                    .transition(.opacity)

            case .transforming:
                TransformFlashView(color: selected.color)
                    .transition(.opacity)

            case .transformed:
                AlienDetailView(alien: selected, onRevert: revert)
                    .transition(.scale(scale: 1.2).combined(with: .opacity))
            }
        }
        .onAppear(perform: applyDebugLaunchArguments)
        .animation(.easeInOut(duration: 0.25), value: phase)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: AlienRoster.index(forCrownValue: crownValue))
    }

    private func transform() {
        guard phase == .selecting else { return }
        WKInterfaceDevice.current().play(.start)
        phase = .transforming
        Task {
            try? await Task.sleep(for: .milliseconds(700))
            WKInterfaceDevice.current().play(.success)
            phase = .transformed
        }
    }

    private func revert() {
        WKInterfaceDevice.current().play(.stop)
        phase = .selecting
    }

    /// DEBUG only, for simulator screenshots:
    /// `-startAlien 5` selects an alien, `-startTransformed YES` opens its detail screen.
    private func applyDebugLaunchArguments() {
        #if DEBUG
        let defaults = UserDefaults.standard
        guard defaults.object(forKey: "startAlien") != nil else { return }
        crownValue = Double(defaults.integer(forKey: "startAlien"))
        if defaults.bool(forKey: "startTransformed") { phase = .transformed }
        #endif
    }
}

#Preview {
    ContentView()
}
