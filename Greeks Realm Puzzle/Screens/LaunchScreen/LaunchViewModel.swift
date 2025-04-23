//
//  LaunchViewModel.swift
//  Thunder Olimp
//
//  Created by Protsak Dmytro on 06.04.2025.
//

import SwiftUI

final class LaunchViewModel: ObservableObject {
    @Published var navigateToHome = false
    @AppStorage("isMusicEnabled") var isMusicEnabled: Bool = false
    let soundManager = SoundManager.shared

    func onViewAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.navigateToHome = true
        }
        
        if isMusicEnabled {
            soundManager.toggleMusic(true)
        }
    }
}
