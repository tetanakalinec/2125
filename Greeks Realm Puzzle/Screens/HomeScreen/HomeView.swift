//
//  HomeView.swift
//  Thunder Olimp
//
//  Created by Protsak Dmytro on 06.04.2025.
//

import SwiftUI

struct HomeView: View {
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

extension HomeView {
    var header: some View {
        HStack {
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

// MARK: - Play Button

extension HomeView {
    var playButton: some View {
        NavigationLink {
            GameTypeView()
        } label: {
            Image(.play)
                .resizable()
                .scaledToFit()
        }
        .frame(height: 90)
    }
}

#Preview {
    HomeView()
}
