//
//  Extension.swift
//  UpdateWifiProps
//
//  Created by k2 tam on 27/11/2023.
//

import UIKit
import Foundation

extension UIColor{
    /// Convert hex string to color
    /// - Parameters:
    ///   - hex: 6 char or 8 char, alpha is the first 2 char in 8 char string
    ///   - alpha: alpha value
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hex = hex.replacingOccurrences(of: "#", with: "")
        var rgbValue: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgbValue)
        if hex.count == 6  {
            let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        } else if hex.count == 8 {
            
            var hexAlpha = Float((rgbValue & 0xFF000000) >> 24) / 255.0
            hexAlpha = round(hexAlpha * 100) / 100
            let red = CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0
            let green = CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0
            let blue = CGFloat(rgbValue & 0x000000FF) / 255.0
            self.init(red: red, green: green, blue: blue, alpha: CGFloat(hexAlpha))
        } else {
            self.init(red: 0, green: 0, blue: 0, alpha: alpha)
        }
        
    }
}

