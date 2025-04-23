import SwiftUI

enum GameType {
    case arcada, campaign
}

struct GRGameTypeView: View {
    
    @AppStorage("selectedMapIndex") var selectedMapIndex: Int = 0
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 40) {
            header
            Text("Choose game".uppercased())
                .foregroundStyle(.white)
                .font(.inknut(size: 32))
            NavigationLink {
                selectedMap(index: selectedMapIndex)
            } label: {
                Image(.arcada)
            }
            .padding(.top, 30)
            
            NavigationLink {
                GRLevelView()
            } label: {
                Image(.campaign)
            }
            Spacer()
        }
        .padding(20)
        .hideNavigationBar()
        .background(
            ZStack {
                Color(.white)
                Image(.emptyBackground)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                Color(.black).opacity(0.1).ignoresSafeArea()
            }
        )
    }
}

// MARK: - Header

extension GRGameTypeView {
    var header: some View {
        HStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(.back)
                    .resizable()
                    .scaledToFit()
            }
            
            Spacer()
            
            NavigationLink {
                GRMenuView()
            } label: {
                Image(.settings)
                    .resizable()
                    .scaledToFit()
            }
        }
        .frame(height: 50)
    }
}

extension GRGameTypeView {
    func selectedMap(index: Int) -> GameView {
        if index == 0 {
            return GameView(
                viewModel: GameViewModel(
                    difficultyLevel: .medium,
                    gameNumber: 1,
                    gameType: .arcada
                )
            )
        } else if index == 1 {
            return GameView(
                viewModel: GameViewModel(
                    difficultyLevel: .medium,
                    gameNumber: 2,
                    gameType: .arcada
                )
            )
        } else if index == 2 {
            return GameView(
                viewModel: GameViewModel(
                    difficultyLevel: .medium,
                    gameNumber: 3,
                    gameType: .arcada
                )
            )
        } else {
            return GameView(
                viewModel: GameViewModel(
                    difficultyLevel: .medium,
                    gameNumber: 4,
                    gameType: .arcada
                )
            )
        }
    }
}

#Preview {
    GRGameTypeView()
}
