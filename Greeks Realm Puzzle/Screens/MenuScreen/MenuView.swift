//
//  MenuView.swift
//  Thunder Olimp
//
//  Created by Protsak Dmytro on 06.04.2025.
//

import SwiftUI

struct MenuView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = MenuViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            header
            content
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

extension MenuView {
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
            Text("Menu".uppercased())
                .foregroundStyle(.white)
                .font(.inknut(size: 35))
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

extension MenuView {
    var content: some View {
        VStack {
            MenuItem(title: "My account", destination: AccountView())
            Toggle(isOn: $viewModel.isMusicEnabled, label: {
                Text("Sound")
            })
            .toggleStyle(
                CustomToggleStyle()
            )
            .onChange(of: viewModel.isMusicEnabled) { newValue in
                viewModel.toggleMusic(newValue)
            }
            
            Toggle(isOn: $viewModel.isVibrationEnabled, label: {
                Text("Vibration")
            })
            .toggleStyle(
                CustomToggleStyle()
            )
            .onChange(of: viewModel.isVibrationEnabled) { newValue in
                viewModel.toggleVibration(newValue)
            }
            MenuItem(title: "Privacy Policy", destination: TextView(screenType: .policy))
            MenuItem(title: "Terms of use", destination: TextView(screenType: .terms))
            Button {
                viewModel.clearData()
            } label: {
                HStack(spacing: 16) {
                    Text("Clear Data")
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Image(systemName: "arrow.right")
                        .font(.largeTitle)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 50)
            }
            Button {
                viewModel.requestRarting()
            } label: {
                HStack(spacing: 16) {
                    Text("Rate app")
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Image(systemName: "arrow.right")
                        .font(.largeTitle)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 50)
            }
            MenuItem(title: "Leaderboard", destination: LeaderboardView())
            MenuItem(title: "Shop", destination: ShopView())
        }
        .padding()
        .foregroundStyle(.white)
        .font(.inknut(size: 25))
        .customBackground(
            maxWidth: .infinity,
            cornerRadius: 20,
            strokeColor: .white,
            backgroundColor: .customBlack
        )
    }
}

struct MenuItem<Destination: View>: View {
    let title: String
    let destination: Destination

    var body: some View {
        NavigationLink {
            destination
        } label: {
            HStack(spacing: 16) {
                Text(title)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                Spacer()
                Image(systemName: "arrow.right")
                    .font(.largeTitle)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 40)
        }
    }
}

#Preview {
    MenuView()
}
