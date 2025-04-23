//
//  LeaderboardViewModel.swift
//  Thunder Olimp
//
//  Created by Protsak Dmytro on 06.04.2025.
//

import SwiftUI

final class LeaderboardViewModel: ObservableObject {
    
    @AppStorage("name") private var name: String = ""
    @AppStorage("bestScore") private var bestScore: Int = 0
    @Published var sortedLeaderboard: [(key: String, value: Int)] = []
    
    private enum JestersLeaderboard {
        static var list: [String: Int] = [
            "starChaser" : 60,
            "darkKnight" : 55,
            "silverArrow" : 54,
            "phantomBlade" : 50,
            "crimsonFlame" : 40,
            "blueFalcon" : 38,
            "goldenEagle" : 35,
            "shadowWraith" : 33,
            "cosmicRider" : 31,
            "loneWolf" : 30,
            "venomFang" : 20,
            "thunderStrike" : 15,
            "icePhoenix" : 13,
            "windSpirit" : 10,
        ]
    }
}

extension LeaderboardViewModel {
    func updateLeaderboard() {
        var leaderBoard = JestersLeaderboard.list
        let playerName = name.isEmpty ? "User" : name
        
        if bestScore > 0 {
            if let existingScore = leaderBoard[playerName] {
                leaderBoard[playerName] = max(existingScore, bestScore)
            } else {
                leaderBoard[playerName] = bestScore
            }
        }
        
        sortedLeaderboard = leaderBoard.sorted(by: { $0.value < $1.value })
        
        if bestScore > 0 && !sortedLeaderboard.prefix(15).contains(where: { $0.key == playerName }) {
            sortedLeaderboard = Array(sortedLeaderboard.prefix(14)) + [(key: playerName, value: bestScore)]
            sortedLeaderboard.sort(by: { $0.value < $1.value })
        }
    }
}
