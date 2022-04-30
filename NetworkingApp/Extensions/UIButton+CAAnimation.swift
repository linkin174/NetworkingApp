//
//  UIButton+CAAnimation.swift
//  NetworkingApp
//
//  Created by Aleksandr Kretov on 01.05.2022.
//

import Foundation
import UIKit

extension UIButton {
    
    func fadeOut() {
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.duration = 0.4
        fadeOut.fromValue = 1.0
        fadeOut.toValue = 0.0
        layer.add(fadeOut, forKey: "fadeOut")
        perform(#selector(showHideButton), with: .none, afterDelay: fadeOut.duration)
    }
    
    func fadeIn() {
        let fadeIn = CABasicAnimation(keyPath: "opacity")
        fadeIn.duration = 0.6
        fadeIn.fromValue = 0.0
        fadeIn.toValue = 1.0
        layer.add(fadeIn, forKey: "fadeIn")
        perform(#selector(showHideButton), with: .none, afterDelay: 0)
    }
    
    @objc func showHideButton() {
        self.isHidden.toggle()
    }
}

