//
//  ShopViewModel.swift
//  Thunder Olimp
//
//  Created by Protsak Dmytro on 06.04.2025.
//

import SwiftUI

final class ShopViewModel: ObservableObject {
    
    @AppStorage("coins") var coins: Int = 0
    
    @AppStorage("isSecondMapEnabled") var isSecondMapEnabled: Bool = false
    @AppStorage("isThirdMapEnabled") var isThirdMapEnabled: Bool = false
    @AppStorage("isFourthMapEnabled") var isFourthMapEnabled: Bool = false
    
    @AppStorage("selectedMapIndex") var selectedMapIndex: Int = 0
    
    func selectMap(index: Int) {
        guard index >= 0 && index <= 3 else { return }

        switch index {
        case 0:
            selectedMapIndex = 0
        case 1:
            if isSecondMapEnabled {
                selectedMapIndex = 1
            } else if coins >= 50 {
                coins -= 50
                isSecondMapEnabled = true
                selectedMapIndex = 1
            }
        case 2:
            if isThirdMapEnabled {
                selectedMapIndex = 2
            } else if coins >= 50 {
                coins -= 50
                isThirdMapEnabled = true
                selectedMapIndex = 2
            }
        case 3:
            if isFourthMapEnabled {
                selectedMapIndex = 3
            } else if coins >= 50 {
                coins -= 50
                isFourthMapEnabled = true
                selectedMapIndex = 3
            }
        default:
            break
        }
    }
}
