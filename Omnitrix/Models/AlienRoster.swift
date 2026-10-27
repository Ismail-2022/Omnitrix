import Foundation

/// The 19 original-series aliens, in Digital Crown scroll order.
enum AlienRoster {

    static let all: [Alien] = [
        Alien(id: 0, name: "Heatblast", species: "Pyronite", homeworld: "Pyros",
              power: "Controls and projects intense fire.",
              symbol: "flame.fill", colorHex: 0xFF5A1F),
        Alien(id: 1, name: "Wildmutt", species: "Vulpimancer", homeworld: "Vulpin",
              power: "Feral beast with enhanced senses, especially smell and hearing.",
              symbol: "pawprint.fill", colorHex: 0xFF8C1A),
        Alien(id: 2, name: "Diamondhead", species: "Petrosapien", homeworld: "Petropia",
              power: "Body of living crystal; creates and shoots crystal shards.",
              symbol: "diamond.fill", colorHex: 0x3FE0D0),
        Alien(id: 3, name: "XLR8", species: "Kineceleran", homeworld: "Kinet",
              power: "Super speed and agility; creates cyclones by running.",
              symbol: "hare.fill", colorHex: 0x2F7BFF),
        Alien(id: 4, name: "Grey Matter", species: "Galvan", homeworld: "Galvan Prime",
              power: "Tiny but incredibly intelligent.",
              symbol: "brain.head.profile", colorHex: 0xA0A6AD),
        Alien(id: 5, name: "Four Arms", species: "Tetramand", homeworld: "Khoros",
              power: "Four-armed powerhouse with huge strength.",
              symbol: "figure.strengthtraining.traditional", colorHex: 0xE0312B),
        Alien(id: 6, name: "Stinkfly", species: "Lepidopterran", homeworld: "Lepidopterra",
              power: "Can fly and shoot toxic slime.",
              symbol: "ladybug.fill", colorHex: 0x9ACD32),
        Alien(id: 7, name: "Ripjaws", species: "Piscciss Volann", homeworld: "Piscciss",
              power: "Aquatic alien with powerful jaws; strongest in water.",
              symbol: "fish.fill", colorHex: 0x5A8FA8),
        Alien(id: 8, name: "Upgrade", species: "Galvanic Mechamorph", homeworld: "Galvan B",
              power: "Merges with technology and upgrades it.",
              symbol: "cpu.fill", colorHex: 0x39FF14),
        Alien(id: 9, name: "Ghostfreak", species: "Ectonurite", homeworld: "Anur Phaetos",
              power: "Ghost-like; can turn intangible and invisible.",
              symbol: "eye.slash.fill", colorHex: 0xB9B3D6),
        Alien(id: 10, name: "Cannonbolt", species: "Arburian Pelarota", homeworld: nil,
              power: "Curls into an armoured ball and rolls at high speed.",
              symbol: "circle.circle.fill", colorHex: 0xF2E3B3),
        Alien(id: 11, name: "Wildvine", species: "Florauna", homeworld: nil,
              power: "Plant-like alien with vines, thorns and regeneration.",
              symbol: "leaf.fill", colorHex: 0x2E8B3A),
        Alien(id: 12, name: "Blitzwolfer", species: "Loboan", homeworld: nil,
              power: "Werewolf-like alien with sonic howls.",
              symbol: "waveform", colorHex: 0x7C8A99),
        Alien(id: 13, name: "Snare-oh", species: "Thep Khufan", homeworld: nil,
              power: "Mummy-like alien with a stretching bandage body.",
              symbol: "bandage.fill", colorHex: 0xD8C48A),
        Alien(id: 14, name: "Frankenstrike", species: "Transylian", homeworld: nil,
              power: "Electricity-powered, Frankenstein-style alien.",
              symbol: "bolt.fill", colorHex: 0x6EC6FF),
        Alien(id: 15, name: "Upchuck", species: "Gourmand", homeworld: nil,
              power: "Eats almost anything and spits it out as explosive projectiles.",
              symbol: "mouth.fill", colorHex: 0x6BA34A),
        Alien(id: 16, name: "Ditto", species: "Splixson", homeworld: nil,
              power: "Creates multiple clones of himself.",
              symbol: "person.3.fill", colorHex: 0xF5F5F5),
        Alien(id: 17, name: "Eye Guy", species: "Opticoid", homeworld: nil,
              power: "Body covered in eyes that fire energy beams.",
              symbol: "eye.fill", colorHex: 0xE6A23C),
        Alien(id: 18, name: "Way Big", species: "To'kustar", homeworld: nil,
              power: "Gigantic alien with immense strength and energy attacks.",
              symbol: "figure.arms.open", colorHex: 0xD7263D),
    ]

    /// Maps a (possibly out-of-range) Digital Crown value to a roster index,
    /// rounding to the nearest detent and wrapping in both directions.
    static func index(forCrownValue value: Double) -> Int {
        let count = all.count
        let raw = Int(value.rounded()) % count
        return raw >= 0 ? raw : raw + count
    }

    static func alien(forCrownValue value: Double) -> Alien {
        all[index(forCrownValue: value)]
    }
}
