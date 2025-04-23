//
//  LevelView.swift
//  Thunder Olimp
//
//  Created by Protsak Dmytro on 06.04.2025.
//

import SwiftUI

struct LevelView: View {

    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = LevelViewModel()
    @State var levelState: LevelState = .level
    @State var selectedDifficulty: DifficultyLevel = .easy
    @State var selectedGame: Int = 1

    var body: some View {
        VStack(spacing: 30) {
            header
            levelContainer
            Spacer()
            if levelState == .game {
                playButton
            }
        }
        .padding(20)
        .navigationBarHidden(true)
        .background(
            ZStack {
                Color(.white)
                Image(.emptyBackground)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                Color(.black).opacity(0.2).ignoresSafeArea()
            }
        )
        .onAppear {
            viewModel.loadLevels()
        }
    }
}

// MARK: - Header

extension LevelView {
    var header: some View {
        HStack {
            Button {
                if levelState == .game {
                    levelState = .level
                } else {
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Image(.back)
                    .resizable()
                    .scaledToFit()
            }
            Spacer()

            NavigationLink {
                MenuView()
            } label: {
                Image(.settings)
                    .resizable()
                    .scaledToFit()
            }

        }
        .frame(height: 50)
    }
}

// MARK: - ContainerTitle

extension LevelView {
    var containerTitle: some View {
        Text(levelState.title.uppercased())
            .foregroundColor(.white)
            .font(.system(size: 35, weight: .bold))
    }
}

// MARK: - Level Container

extension LevelView {
    var levelContainer: some View {
        VStack(spacing: 10) {
            containerTitle
            VStack {
                if levelState == .level {
                    levels
                } else {
                    games
                }
            }
        }
    }
}

// MARK: - Levels

extension LevelView {
    var levels: some View {
        VStack(spacing: 30) {
            ForEach(DifficultyLevel.allCases, id: \.self) { level in
                if let isUnlocked = viewModel.unlockedLevels[level]?[0], isUnlocked {
                    // Level is unlocked
                    Button {
                        levelState = .game
                        selectedDifficulty = level
                        selectedGame = 1
                    } label: {
                        Text(level.title.uppercased())
                            .frame(maxWidth: .infinity, maxHeight: 83)
                            .background(
                                (selectedDifficulty == level)
                                ? Color.customBlue
                                : Color.customGrayy
                            )
                            .foregroundColor(.white)
                            .cornerRadius(40)
                    }
                } else {
                    // Level is locked
                    ZStack(alignment: .bottom) {
                        Text(level.title.uppercased())
                            .frame(maxWidth: .infinity, maxHeight: 83)
                            .background(Color.customGrayy)
                            .foregroundColor(.white)
                            .cornerRadius(40)
                        Image(systemName: "lock.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                            .offset(y: 10)
                    }
                }
            }
        }
        .font(.inknut(size: 30))
    }
}

// MARK: - Games

extension LevelView {
    var games: some View {
        VStack(spacing: 10) {
            ForEach(1...4, id: \.self) { index in
                if let isUnlocked = viewModel.unlockedLevels[selectedDifficulty]?[index - 1], isUnlocked {
                    Button {
                        selectedGame = index
                    } label: {
                        Text("\(index)")
                            .frame(width: 170, height: 70)
                            .font(.inknut(size: 35))
                            .offset(y: -4)
                            .background(
                                (selectedGame == index)
                                ? Color.customBlue
                                : Color.customGrayy
                            )
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
                } else {
                    // Game is locked
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.customGrayy)
                            .frame(width: 170, height: 70)
                        Image(systemName: "lock.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                    }
                }
            }
        }
    }
}

// MARK: - Play Button

extension LevelView {
    var playButton: some View {
        NavigationLink(
            destination: Group {
                if viewModel.unlockedLevels[selectedDifficulty]?[selectedGame - 1] == true {
                    GameView(
                        viewModel: GameViewModel(
                            difficultyLevel: selectedDifficulty,
                            gameNumber: selectedGame,
                            gameType: .campaign
                        )
                    )
                } else {
                    EmptyView()
                }
            }
        ) {
            Image(.play)
                .resizable()
                .scaledToFit()
                .frame(height: 90)
                .opacity(viewModel.unlockedLevels[selectedDifficulty]?[selectedGame - 1] == true ? 1.0 : 0.5)
        }
        .disabled(!(viewModel.unlockedLevels[selectedDifficulty]?[selectedGame - 1] == true))
    }
}

#Preview {
    LevelView()
}
