//
//  UIVIew+CAAnimation.swift
//  NetworkingApp
//
//  Created by Aleksandr Kretov on 01.05.2022.
//

import Foundation
import UIKit

extension UIView {
    
    //TODO: add some background movement
    func scaleAnimation() {
        
        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.duration = 10
        scale.fromValue = 1
        scale.toValue = 1.1
        scale.autoreverses = true
        scale.repeatCount = 3

        let moveX = CABasicAnimation(keyPath: "transform.translation.x")
        moveX.fromValue = 0
        moveX.toValue = 40
        moveX.duration = 10
        moveX.autoreverses = true
        moveX.repeatCount = 3
        
        let moveY = CABasicAnimation(keyPath: "transform.translation.y")
        moveY.fromValue = -50
        moveY.toValue = 50
        moveY.duration = 10
        moveY.autoreverses = true
        moveY.repeatCount = 3
        
        layer.add(scale, forKey: nil)
        layer.add(moveX, forKey: nil)
//        layer.add(moveY, forKey: nil)
    }
    
}
