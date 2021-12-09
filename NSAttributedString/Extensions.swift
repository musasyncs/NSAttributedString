//
//  Extensions.swift
//  NSAttributedString
//
//  Created by Ewen on 2021/12/9.
//

import UIKit

// MARK: - Label
func makeLabel() -> UILabel {
    return makeLabel(withTitle: "")
}

func makeLabel(withTitle title: String) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = title
    label.textAlignment = .center
    label.textColor = .black
    label.numberOfLines = 0
    label.adjustsFontSizeToFitWidth = true
    return label
}

// MARK: - StackView
func makeVerticalStackView() -> UIStackView {
    let stack = UIStackView()
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    stack.spacing = 32
    return stack
}

// MARK: - UIFont Extension
extension UIFont {
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0) //size 0 means keep the size as it is
    }
}

// MARK: - UIColor Extension
extension UIColor {
    static let spotifyGreen = UIColor(red: 28/255, green: 184/255, blue: 89/255, alpha: 1)
}

// MARK: - UIImage Extension
extension UIImage {
    func resize(to goalSize: CGSize) -> UIImage? {
        let widthRatio = goalSize.width / size.width
        let heightRatio = goalSize.height / size.height
        let ratio = widthRatio < heightRatio ? widthRatio : heightRatio
        
        let resizedSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0)
        draw(in: CGRect(origin: .zero, size: resizedSize))
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
}

// MARK: - Decimal Extension
extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
