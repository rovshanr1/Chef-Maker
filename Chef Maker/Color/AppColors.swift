//
//  AppColors.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 08.04.25.
//

import SwiftUI

struct AppColors {
    // Light Mode Colors
    static let lightBackground = Color(hex: "#E1EFD4")
    static let lightCardBackground = Color.white
    static let lightAccent = Color(hex: "#7BAE68")
    static let lightText = Color.primary

    // Dark Mode Colors
    static let darkBackground = Color(hex: "#232421")
    static let darkCardBackground = Color(hex: "#2C2C2C")
    static let darkAccent = Color(hex: "#A8D8A0")
    static let darkText = Color.white
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
