//
//  UIView+Extension.swift
//  Tip Calculator
//
//  Created by nkkha on 7/5/24.
//

import UIKit

extension UIView {
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.cornerRadius = radius
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor = backgroundCGColor
    }
    
    func addRadius(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = false
    }
}
