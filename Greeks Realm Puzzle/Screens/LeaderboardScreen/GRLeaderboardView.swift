import SwiftUI

struct GRLeaderboardView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = GRLeaderboardViewModel()
    
    var body: some View {
        VStack {
            header
            Spacer()
            listContainer
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .hideNavigationBar()
        .onAppear {
            viewModel.updateLeaderboard()
        }
        .background(
            ZStack {
                Color(.white)
                Image(.emptyBackground)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                Color(.black.withAlphaComponent(0.1)).ignoresSafeArea()
            }
        )
    }
}

// MARK: - Header

extension GRLeaderboardView {
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
            Text("Leaderboard")
                .font(.inknut(size: 25))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
            Spacer()
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(.back)
                    .resizable()
                    .scaledToFit()
            }
            .opacity(0)
        }
        .frame(height: 50)
    }
}

// MARK: - ListContainer

extension GRLeaderboardView {
    var listContainer: some View {
        VStack(spacing: 20) {
            list
        }
        .foregroundStyle(.white)
        .font(.inknut(size: 20))
        .padding(.top, 20)
    }
}

// MARK: - ListContainer

extension GRLeaderboardView {
    var list: some View {
        ScrollView(showsIndicators: false) {
            ForEach(Array(viewModel.sortedLeaderboard.prefix(15).enumerated()), id: \.element.key) {
                index,
                element in
                VStack(spacing: 15) {
                    HStack(alignment: .center) {
                        Text("\(element.key)")
                            .minimumScaleFactor(0.3)
                        Spacer()
                        Text("Score: \(element.value)s")
                    }
                    .font(.inknut(size: 18))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .customBackground(
                        maxWidth: .infinity,
                        cornerRadius: 10,
                        strokeColor: .white,
                        backgroundColor: .customBlue
                    )
                    .frame(height: 30)

                }
                .padding(.vertical, 10)
            }
        }
        .padding()
        .customBackground(
            maxWidth: .infinity,
            cornerRadius: 20,
            strokeColor: .white,
            backgroundColor: .customBlack
        )
    }
}

#Preview {
    GRLeaderboardView()
}
