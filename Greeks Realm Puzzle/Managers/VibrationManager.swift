import AVFoundation
import SwiftUI

protocol VibrationManagerProtocol {
    func toggleVibration(_ enable: Bool)
    func vibrate()
}

final class VibrationManager: ObservableObject {
    
    static let shared = VibrationManager()
    
    @AppStorage("isVibrationEnabled") var isVibrationEnabled = false
    
    private init() {}
    
    func toggleVibration(_ enable: Bool) {
        isVibrationEnabled = enable
    }
    
    func vibrate() {
        guard isVibrationEnabled else { return }
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}
