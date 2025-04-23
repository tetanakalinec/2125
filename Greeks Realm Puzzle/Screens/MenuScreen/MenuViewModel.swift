//
//  MenuViewModel.swift
//  Thunder Olimp
//
//  Created by Protsak Dmytro on 06.04.2025.
//

import SwiftUI
import StoreKit

final class MenuViewModel: ObservableObject {
    
    @ObservedObject var soundAvManager = SoundManager.shared
    @ObservedObject var vibrationManager = VibrationManager.shared
    
    @AppStorage("isMusicEnabled") var isMusicEnabled: Bool = true
    @AppStorage("isVibrationEnabled") var isVibrationEnabled: Bool = false
    
    @AppStorage("coins") var coins: Int = 0
    @AppStorage("bestScore") var bestScore: Int = 0
    
    @AppStorage("isSecondMapEnabled") var isSecondMapEnabled: Bool = false
    @AppStorage("isThirdMapEnabled") var isThirdMapEnabled: Bool = false
    @AppStorage("isFourthMapEnabled") var isFourthMapEnabled: Bool = false
    
    @AppStorage("name") var name: String = ""
    
    @AppStorage("selectedMapIndex") var selectedMapIndex: Int = 0
    
    @AppStorage("easyLevel1Unlocked") private var easyLevel1Unlocked: Bool = true
    @AppStorage("easyLevel2Unlocked") private var easyLevel2Unlocked: Bool = false
    @AppStorage("easyLevel3Unlocked") private var easyLevel3Unlocked: Bool = false
    @AppStorage("easyLevel4Unlocked") private var easyLevel4Unlocked: Bool = false

    @AppStorage("mediumLevel1Unlocked") private var mediumLevel1Unlocked: Bool = false
    @AppStorage("mediumLevel2Unlocked") private var mediumLevel2Unlocked: Bool = false
    @AppStorage("mediumLevel3Unlocked") private var mediumLevel3Unlocked: Bool = false
    @AppStorage("mediumLevel4Unlocked") private var mediumLevel4Unlocked: Bool = false

    @AppStorage("hardLevel1Unlocked") private var hardLevel1Unlocked: Bool = false
    @AppStorage("hardLevel2Unlocked") private var hardLevel2Unlocked: Bool = false
    @AppStorage("hardLevel3Unlocked") private var hardLevel3Unlocked: Bool = false
    @AppStorage("hardLevel4Unlocked") private var hardLevel4Unlocked: Bool = false
    
}

extension MenuViewModel {
    func toggleMusic(_ isEnabled: Bool) {
        soundAvManager.toggleMusic(isEnabled)
    }
    
    func toggleVibration(_ isEnabled: Bool) {
        vibrationManager.toggleVibration(isEnabled)
    }
    
    func clearData() {
        coins = 0
        bestScore = 0
        isSecondMapEnabled = false
        isThirdMapEnabled = false
        isFourthMapEnabled = false
        PhotoManager.shared.profileImage = nil
        name = ""
        selectedMapIndex = 0
        
        easyLevel1Unlocked = true
        easyLevel2Unlocked = false
        easyLevel3Unlocked = false
        easyLevel4Unlocked = false
        
        mediumLevel1Unlocked = false
        mediumLevel2Unlocked = false
        mediumLevel3Unlocked = false
        mediumLevel4Unlocked = false
        
        hardLevel1Unlocked = false
        hardLevel2Unlocked = false
        hardLevel3Unlocked = false
        hardLevel4Unlocked = false
    }
    
    func requestRarting() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
}
