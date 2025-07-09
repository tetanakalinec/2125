//
//  UIViewController+Extensions.swift
//  Greeks Realm Puzzle
//
//  Created by Protsak Dmytro on 21.05.2025.
//

import UIKit

extension UIViewController {
    func topMostPresentedViewController() -> UIViewController {
        var top = self
        while let presented = top.presentedViewController {
            top = presented
        }
        return top
    }
}
