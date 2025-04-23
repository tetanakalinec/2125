import SwiftUI

enum LevelState {
    case level
    case game

    var title: String {
        switch self {
        case .level:
            return "Choose Level"
        case .game:
            return "Choose Game"
        }
    }
}

final class GRLevelViewModel: ObservableObject {
    @AppStorage("easyLevel1Unlocked") private var easyLevel1Unlocked: Bool = true
    @AppStorage("easyLevel2Unlocked") private var easyLevel2Unlocked: Bool = false
    @AppStorage("easyLevel3Unlocked") private var easyLevel3Unlocked: Bool = false
    @AppStorage("easyLevel4Unlocked") private var easyLevel4Unlocked: Bool = false

    @AppStorage("mediumLevel1Unlocked") private var mediumLevel1Unlocked: Bool = false
    @AppStorage("mediumLevel2Unlocked") private var mediumLevel2Unlocked: Bool = false
    @AppStorage("mediumLevel3Unlocked") private var mediumLevel3Unlocked: Bool = false
    @AppStorage("mediumLevel4Unlocked") private var mediumLevel4Unlocked: Bool = false

    @AppStorage("hardLevel1Unlocked") private var hardLevel1Unlocked: Bool = false
    @AppStorage("hardLevel2Unlocked") private var hardLevel2Unlocked: Bool = false
    @AppStorage("hardLevel3Unlocked") private var hardLevel3Unlocked: Bool = false
    @AppStorage("hardLevel4Unlocked") private var hardLevel4Unlocked: Bool = false

    @Published var unlockedLevels: [GRDifficultyLevel: [Bool]] = [:]

    init() {
        loadLevels()
    }

    func loadLevels() {
        unlockedLevels = [
            .easy: [
                easyLevel1Unlocked,
                easyLevel2Unlocked,
                easyLevel3Unlocked,
                easyLevel4Unlocked
            ],
            .medium: [
                mediumLevel1Unlocked,
                mediumLevel2Unlocked,
                mediumLevel3Unlocked,
                mediumLevel4Unlocked
            ],
            .hard: [
                hardLevel1Unlocked,
                hardLevel2Unlocked,
                hardLevel3Unlocked,
                hardLevel4Unlocked
            ]
        ]
    }
}
