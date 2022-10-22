//
//  UIView+Extension.swift
//  GymBuddy
//
//  Created by Samir on 10/22/22.
//

import UIKit

// MARK: - UIView Inspectables
extension UIView {

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable
    var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        }
    }

    @IBInspectable
    var shadowBlur: CGFloat {
        get { return layer.shadowRadius * 2 }
        set { layer.shadowRadius = newValue / 2}
    }

    @IBInspectable
    var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        set {layer.shadowOpacity = newValue / 100}
    }

    @IBInspectable
    var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
}
