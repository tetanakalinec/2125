//
//  LaunchView.swift
//  Thunder Olimp
//
//  Created by Protsak Dmytro on 05.04.2025.
//

import SwiftUI

struct LaunchView: View {
    
    @StateObject private var viewModel = LaunchViewModel()

    var body: some View {
        NavigationView {
            VStack {
               
                // - Transition
                NavigationLink(
                    destination: HomeView(),
                    isActive: $viewModel.navigateToHome
                ) {
                    EmptyView()
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                ZStack {
                    Color(.white)
                    Image(.launchBackground)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .hideNavigationBar()
        .onAppear {
            viewModel.onViewAppear()
        }
    }
}

#Preview {
    LaunchView()
}
