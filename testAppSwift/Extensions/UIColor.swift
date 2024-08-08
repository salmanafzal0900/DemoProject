//
//  UIColor.swift
//  testAppSwift
//
//  Created by Salman Afzal on 08/08/2024.
//

import UIKit

extension UIColor {
    // Initialize UIColor from a hex string
    convenience init(hex: String) {
        let r, g, b, a: CGFloat
        
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        if hexSanitized.count == 6 {
            //  RGB (24-bit)
            let scanner = Scanner(string: hexSanitized)
            var hexInt: UInt64 = 0
            scanner.scanHexInt64(&hexInt)
            
            r = CGFloat((hexInt >> 16) & 0xFF) / 255.0
            g = CGFloat((hexInt >> 8) & 0xFF) / 255.0
            b = CGFloat(hexInt & 0xFF) / 255.0
            a = 1.0
            
        } else if hexSanitized.count == 8 {
            // ARGB (32-bit)
            let scanner = Scanner(string: hexSanitized)
            var hexInt: UInt64 = 0
            scanner.scanHexInt64(&hexInt)
            
            r = CGFloat((hexInt >> 24) & 0xFF) / 255.0
            g = CGFloat((hexInt >> 16) & 0xFF) / 255.0
            b = CGFloat((hexInt >> 8) & 0xFF) / 255.0
            a = CGFloat(hexInt & 0xFF) / 255.0
            
        } else {
            // Default to white if the hex string is invalid
            r = 1.0
            g = 1.0
            b = 1.0
            a = 1.0
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
