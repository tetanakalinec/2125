import SwiftUI

struct GRHomeView: View {
    
    let soundManager = SoundManager.shared
    
    var body: some View {
        ZStack {
            VStack {
                Image(.olimTitle)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                
                Spacer()
                Image(.girl)
                    .resizable()
                    .scaledToFit()
            }
            .padding([.top, .horizontal], 20)
            .padding(.top, 70)
            .ignoresSafeArea(.all, edges: .bottom)
            VStack {
                header
                Spacer()
                playButton
            }
            .padding(20)
        }
        .background(
            ZStack {
                Color(.white)
                Image(.emptyBackground)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
        )
        .hideNavigationBar()
        .onAppear {
            AppDelegate.orientationLock = [.portrait]
            if soundManager.isMusicEnabled {
                soundManager.enableNotificationsIfNeeded()
                soundManager.toggleMusic(true)
            }
        }
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
