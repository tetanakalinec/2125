//
//  AppDelegate.swift
//  Greeks Realm Puzzle
//
//  Created by Protsak Dmytro on 27.05.2025.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    static var orientationLock: UIInterfaceOrientationMask = .portrait

    func application(
        _ application: UIApplication,
        supportedInterfaceOrientationsFor window: UIWindow?
    ) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
