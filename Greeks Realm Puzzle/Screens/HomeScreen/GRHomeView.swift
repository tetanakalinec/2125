import SwiftUI

struct GRHomeView: View {
    var body: some View {
        VStack {
            header
            Spacer()
            playButton
        }
        .padding(20)
        .hideNavigationBar()
        .background(
            ZStack {
                Color(.white)
                Image(.homeBackground)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
        )
    }
}

// MARK: - Header

extension GRHomeView {
    var header: some View {
        HStack {
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

// MARK: - Play Button

extension GRHomeView {
    var playButton: some View {
        NavigationLink {
            GRGameTypeView()
        } label: {
            Image(.play)
                .resizable()
                .scaledToFit()
        }
        .frame(height: 90)
    }
}

#Preview {
    GRHomeView()
}
