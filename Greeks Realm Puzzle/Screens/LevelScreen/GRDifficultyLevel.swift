import SwiftUI

enum GRDifficultyLevel: CaseIterable {
    case easy
    case medium
    case hard

    var title: String {
        switch self {
        case .easy:
            return "Easy"
        case .medium:
            return "Medium"
        case .hard:
            return "Hard"
        }
    }

    var gridSize: Int {
        switch self {
        case .easy:
            return 3
        case .medium:
            return 4
        case .hard:
            return 5
        }
    }

    func images(for gameNumber: Int) -> [String] {
        switch self {
        case .easy:
            return Easy(rawValue: gameNumber)?.images ?? []
        case .medium:
            return Medium(rawValue: gameNumber)?.images ?? []
        case .hard:
            return Hard(rawValue: gameNumber)?.images ?? []
        }
    }

    func time(for gameNumber: Int) -> Int {
        switch self {
        case .easy:
            return Easy(rawValue: gameNumber)?.time ?? 0
        case .medium:
            return Medium(rawValue: gameNumber)?.time ?? 0
        case .hard:
            return Hard(rawValue: gameNumber)?.time ?? 0
        }
    }

    var maxGameNumber: Int {
        switch self {
        case .easy:
            return Easy.allCases.count
        case .medium:
            return Medium.allCases.count
        case .hard:
            return Hard.allCases.count
        }
    }

    var nextDifficultyLevel: GRDifficultyLevel? {
        switch self {
        case .easy:
            return .medium
        case .medium:
            return .hard
        case .hard:
            return nil
        }
    }
}

enum Easy: Int, CaseIterable {
    case first = 1, second, third, fourth

    var images: [String] {
        switch self {
        case .first:
            return ["easy1-1","easy1-2","easy1-3","easy1-4", "easy1-5", "easy1-6", "easy1-7", "easy1-8", "easy1-9"]
        case .second:
            return ["easy2-1","easy2-2","easy2-3","easy2-4", "easy2-5", "easy2-6", "easy2-7", "easy2-8", "easy2-9"]
        case .third:
            return ["easy3-1","easy3-2","easy3-3","easy3-4", "easy3-5", "easy3-6", "easy3-7", "easy3-8", "easy3-9"]
        case .fourth:
            return ["easy4-1","easy4-2","easy4-3","easy4-4", "easy4-5", "easy4-6", "easy4-7", "easy4-8", "easy4-9"]
        }
    }

    var time: Int {
        return 60
    }
}

enum Medium: Int, CaseIterable {
    case first = 1, second, third, fourth

    var images: [String] {
        switch self {
        case .first:
            return ["medium1-1","medium1-2","medium1-3","medium1-4","medium1-5","medium1-6","medium1-7","medium1-8","medium1-9", "medium1-10", "medium1-11", "medium1-12", "medium1-13", "medium1-14", "medium1-15", "medium1-16"]
        case .second:
            return ["medium2-1","medium2-2","medium2-3","medium2-4","medium2-5","medium2-6","medium2-7","medium2-8","medium2-9", "medium2-10", "medium2-11", "medium2-12", "medium2-13", "medium2-14", "medium2-15", "medium2-16"]
        case .third:
            return ["medium3-1","medium3-2","medium3-3","medium3-4","medium3-5","medium3-6","medium3-7","medium3-8","medium3-9", "medium3-10", "medium3-11", "medium3-12", "medium3-13", "medium3-14", "medium3-15", "medium3-16"]
        case .fourth:
            return ["medium4-1","medium4-2","medium4-3","medium4-4","medium4-5","medium4-6","medium4-7","medium4-8","medium4-9", "medium4-10", "medium4-11", "medium4-12", "medium4-13", "medium4-14", "medium4-15", "medium4-16"]
        }
    }

    var time: Int {
        return 120
    }
}

enum Hard: Int, CaseIterable {
    case first = 1, second, third, fourth

    var images: [String] {
        switch self {
        case .first:
            return ["hard1-1","hard1-2","hard1-3","hard1-4","hard1-5","hard1-6","hard1-7","hard1-8","hard1-9","hard1-10","hard1-11","hard1-12","hard1-13","hard1-14","hard1-15","hard1-16", "hard1-17", "hard1-18", "hard1-19", "hard1-20", "hard1-21", "hard1-22", "hard1-23", "hard1-24", "hard1-25"]
        case .second:
            return ["hard2-1","hard2-2","hard2-3","hard2-4","hard2-5","hard2-6","hard2-7","hard2-8","hard2-9","hard2-10","hard2-11","hard2-12","hard2-13","hard2-14","hard2-15","hard2-16", "hard2-17", "hard2-18", "hard2-19", "hard2-20", "hard2-21", "hard2-22", "hard2-23", "hard2-24", "hard2-25"]
        case .third:
            return ["hard3-1","hard3-2","hard3-3","hard3-4","hard3-5","hard3-6","hard3-7","hard3-8","hard3-9","hard3-10","hard3-11","hard3-12","hard3-13","hard3-14","hard3-15","hard3-16", "hard3-17", "hard3-18", "hard3-19", "hard3-20", "hard3-21", "hard3-22", "hard3-23", "hard3-24", "hard3-25"]
        case .fourth:
            return ["hard4-1","hard4-2","hard4-3","hard4-4","hard4-5","hard4-6","hard4-7","hard4-8","hard4-9","hard4-10","hard4-11","hard4-12","hard4-13","hard4-14","hard4-15","hard4-16", "hard4-17", "hard4-18", "hard4-19", "hard4-20", "hard4-21", "hard4-22", "hard4-23", "hard4-24", "hard4-25"]
        }
    }

    var time: Int {
        return 240
    }
}
