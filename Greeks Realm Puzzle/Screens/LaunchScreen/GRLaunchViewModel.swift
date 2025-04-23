import SwiftUI

final class GRLaunchViewModel: ObservableObject {
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
