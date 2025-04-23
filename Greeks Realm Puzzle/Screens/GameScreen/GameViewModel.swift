import SwiftUI

struct PuzzlePiece: Identifiable {
    let id: Int
    let imageName: String
}

final class GameViewModel: ObservableObject {

    @AppStorage("bestScore") var bestScore: Int = 0
    @AppStorage("coins") var coins: Int = 0

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
    
    @ObservedObject var vibrationManager = VibrationManager.shared

    @Published var difficultyLevel: GRDifficultyLevel
    @Published var gameNumber: Int
    var gameType: GameType

    @Published var puzzlePieces: [PuzzlePiece] = []
    @Published var firstSelectedPiece: PuzzlePiece?
    @Published var puzzleSolved = false
    @Published var isGameLose = false

    @Published var timeRemaining: Int
    private var totalTime: Int
    private var timer: Timer?

    init(difficultyLevel: GRDifficultyLevel, gameNumber: Int, gameType: GameType) {
        self.difficultyLevel = difficultyLevel
        self.gameNumber = gameNumber
        self.gameType = gameType

        self.totalTime = difficultyLevel.time(for: gameNumber)
        self.timeRemaining = totalTime

        initializePuzzle()
        
        if gameType == .arcada {
            startTimer()
        }
    }

    func initializePuzzle() {
        stopTimer()
        let images = difficultyLevel.images(for: gameNumber)
        puzzlePieces = images.enumerated().map { index, imageName in
            PuzzlePiece(id: index + 1, imageName: imageName)
        }.shuffled()
        puzzleSolved = false
        isGameLose = false
        firstSelectedPiece = nil
        timeRemaining = totalTime
        startTimer()
    }

    func pieceTapped(_ piece: PuzzlePiece) {
        vibrationManager.vibrate()
        if firstSelectedPiece == nil {
            firstSelectedPiece = piece
        } else {
            if firstSelectedPiece!.id != piece.id {
                if let firstIndex = puzzlePieces.firstIndex(where: { $0.id == firstSelectedPiece!.id }),
                   let secondIndex = puzzlePieces.firstIndex(where: { $0.id == piece.id }) {
                    puzzlePieces.swapAt(firstIndex, secondIndex)
                    vibrationManager.vibrate()
                }
                if isPuzzleSolved() {
                    puzzleSolved = true
                    stopTimer()
                    if gameType == .campaign {
                        unlockNextLevel()
                        coins += 10
                    } else {
                        updateBestScoreIfNeeded()
                    }
                }
            }
            firstSelectedPiece = nil
        }
    }

    private func isPuzzleSolved() -> Bool {
        for i in 0..<puzzlePieces.count {
            if puzzlePieces[i].id != i + 1 {
                return false
            }
        }
        return true
    }

    func cellSize() -> (CGFloat, CGFloat) {
        switch difficultyLevel {
        case .easy:
            return (110, 156)
        case .medium:
            return (82, 117)
        case .hard:
            return (66, 94)
        }
    }

    func startTimer() {
        guard gameType == .arcada else { return }
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.stopTimer()
                if !self.puzzleSolved {
                    self.isGameLose = true
                }
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func pauseTimer() {
        stopTimer()
    }

    func resumeTimer() {
        if gameType == .arcada && !puzzleSolved && !isGameLose {
            startTimer()
        }
    }

    func goToNextGame() {
        if gameNumber < difficultyLevel.maxGameNumber {
            gameNumber += 1
        } else if let nextDifficulty = difficultyLevel.nextDifficultyLevel {
            difficultyLevel = nextDifficulty
            gameNumber = 1
        } else {
            difficultyLevel = .easy
            gameNumber = 1
        }
        totalTime = difficultyLevel.time(for: gameNumber)
        timeRemaining = totalTime
        withAnimation {
            initializePuzzle()
        }
    }

    var timeElapsed: Int {
        totalTime - timeRemaining
    }

    var timeElapsedFormatted: String {
        String(format: "%02d:%02d", timeElapsed / 60, timeElapsed % 60)
    }

    var timeRemainingFormatted: String {
        String(format: "%02d:%02d", timeRemaining / 60, timeRemaining % 60)
    }

    // MARK: - Best Score Logic

    func updateBestScoreIfNeeded() {
        if bestScore == 0 || timeElapsed < bestScore {
            bestScore = timeElapsed
        }
    }

    // MARK: - Unlock Next Level Logic

    func unlockNextLevel() {
        var nextDifficultyLevel = difficultyLevel
        var nextGameNumber = gameNumber + 1

        if nextGameNumber > 4 {
            if let nextDifficulty = difficultyLevel.nextDifficultyLevel {
                nextDifficultyLevel = nextDifficulty
                nextGameNumber = 1
            } else {
                nextDifficultyLevel = .easy
                nextGameNumber = 1
            }
        }

        switch nextDifficultyLevel {
        case .easy:
            switch nextGameNumber {
            case 1:
                easyLevel1Unlocked = true
            case 2:
                easyLevel2Unlocked = true
            case 3:
                easyLevel3Unlocked = true
            case 4:
                easyLevel4Unlocked = true
            default:
                break
            }
        case .medium:
            switch nextGameNumber {
            case 1:
                mediumLevel1Unlocked = true
            case 2:
                mediumLevel2Unlocked = true
            case 3:
                mediumLevel3Unlocked = true
            case 4:
                mediumLevel4Unlocked = true
            default:
                break
            }
        case .hard:
            switch nextGameNumber {
            case 1:
                hardLevel1Unlocked = true
            case 2:
                hardLevel2Unlocked = true
            case 3:
                hardLevel3Unlocked = true
            case 4:
                hardLevel4Unlocked = true
            default:
                break
            }
        }
    }
}

