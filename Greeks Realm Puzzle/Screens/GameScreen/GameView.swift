import SwiftUI

struct GameView: View {
    @StateObject var viewModel: GameViewModel
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        ZStack {
            VStack {
                header
                Spacer()
                puzzleGrid
                Spacer()
            }
            .padding([.top, .horizontal], 20)
            .padding(.bottom, 5)
            .hideNavigationBar()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(
                    colors: [.customBG2, .customBG1],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )

            if viewModel.puzzleSolved || viewModel.isGameLose {
                Color.black.opacity(0.5).ignoresSafeArea()
                reusableView
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive {
                viewModel.pauseTimer()
            } else if newPhase == .active {
                viewModel.resumeTimer()
            }
        }
    }
}

// MARK: - Header

extension GameView {
    var header: some View {
        HStack {
            Button {
                viewModel.initializePuzzle()
            } label: {
                Image(.restart)
                    .resizable()
                    .scaledToFit()
            }
            Spacer()
            if viewModel.gameType == .arcada {
                HStack {
                    Image("clock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                    Text(viewModel.timeRemainingFormatted)
                }
                Spacer()
            }

            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(.hom)
                    .resizable()
                    .scaledToFit()
            }

        }
        .frame(height: 50)
        .font(.inknut(size: 32))
        .foregroundColor(.white)
    }
}

// MARK: - Puzzle Grid

extension GameView {
    var puzzleGrid: some View {
        let (itemWidth, itemHeight) = viewModel.cellSize()
        let gridSize = viewModel.difficultyLevel.gridSize
        let columns = Array(repeating: GridItem(.fixed(itemWidth), spacing: 0), count: gridSize)

        return LazyVGrid(columns: columns, spacing: 0) {
            ForEach(viewModel.puzzlePieces) { piece in
                Image(piece.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: itemWidth, height: itemHeight)
                    .clipped()
                    .border(
                        viewModel.firstSelectedPiece?.id == piece.id
                        ? Color.blue
                        : Color.clear,
                        width: 2
                    )
                    .onTapGesture {
                        viewModel.pieceTapped(piece)
                    }
            }
        }
        .padding()
        .customBackground(
            cornerRadius: 20,
            strokeColor: .white,
            backgroundColor: .customBlue
        )
    }
}

// MARK: - Reusable View (Winning/Losing Screen)

extension GameView {
    var reusableView: some View {
        VStack(spacing: 0) {
            Text(viewModel.puzzleSolved ? "Level Completed" : "Level Failed")
                .font(.inknut(size: 30))
                .foregroundColor(viewModel.puzzleSolved ? .white : .customRed)
            
            if viewModel.gameType == .arcada {
                if viewModel.bestScore == 0 {
                    Text("You haven't yet achieved best score")
                        .font(.inknut(size: 10))
                        .foregroundStyle(.white)
                        .offset(y: -20)
                } else {
                    Text("Your best score - \(viewModel.bestScore)s")
                        .font(.inknut(size: 15))
                        .foregroundStyle(.white)
                        .offset(y: -20)
                }
            } else {
                Text("Your coins - \(viewModel.coins)")
                    .font(.inknut(size: 25))
                    .foregroundStyle(.white)
                    .offset(y: -20)
            }
            
            if viewModel.gameType == .campaign {
                HStack {
                    if viewModel.puzzleSolved {
                        Button {
                            viewModel.goToNextGame()
                        } label: {
                            Image(.nextIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 45)
                        }
                    } else {
                        Button {
                            viewModel.initializePuzzle()
                        } label: {
                            Image(.restart)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 45)
                        }
                    }
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(.hom)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 45)
                    }
                }
            } else {
                HStack {
                    Button {
                        viewModel.initializePuzzle()
                    } label: {
                        Image(.restart)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 45)
                    }
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(.hom)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 45)
                    }
                }
            }
        }
        .padding()
        .customBackground(
            maxWidth: .infinity,
            cornerRadius: 20,
            strokeColor: .white,
            backgroundColor: .customBlue
        )
        .padding(.horizontal, 40)
    }
}

#Preview {
    GameView(
        viewModel: GameViewModel(
            difficultyLevel: .easy,
            gameNumber: 1,
            gameType: .campaign
        )
    )
}
