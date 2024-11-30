//
//  Color+.swift
//
//
//  Created by Jiafu Zhang on 3/19/24.
//

import SwiftUI

#if canImport(AppKit)
import AppKit
#endif

#if canImport(UIKit)
import UIKit
#endif

public extension Color {
    init(hsl h: Double, _ s: Double, _ l: Double, opacity: Double = 1) {
        let s = s / 100
        let l = l / 100
        
        let c = (1 - abs(2 * l - 1)) * s
        let x = c * (1 - abs((h / 60).truncatingRemainder(dividingBy: 2) - 1))
        let m = l - c/2
        
        var r, g, b: Double
        
        switch h {
        case 0..<60:
            (r, g, b) = (c, x, 0)
        case 60..<120:
            (r, g, b) = (x, c, 0)
        case 120..<180:
            (r, g, b) = (0, c, x)
        case 180..<240:
            (r, g, b) = (0, x, c)
        case 240..<300:
            (r, g, b) = (x, 0, c)
        default:
            (r, g, b) = (c, 0, x)
        }
        
        self.init(
            red: r + m,
            green: g + m,
            blue: b + m,
            opacity: opacity
        )
    }
}

// Dynamic colors
public extension Color {
    init(_ any: Color, dark: Color) {
        #if canImport(UIKit)
        self.init(any: UIColor(any), dark: UIColor(dark))
        #else
        self.init(any: NSColor(any), dark: NSColor(dark))
        #endif
    }

    #if canImport(UIKit)
    private init(any: UIColor, dark: UIColor) {
        #if os(watchOS)
        // watchOS does not support light mode / dark mode
        // Per Apple HIG, prefer dark-style interfaces
        self.init(uiColor: dark)
        #else
        self.init(uiColor: UIColor(dynamicProvider: { traits in
            switch traits.userInterfaceStyle {
            case .light, .unspecified:
                return any

            case .dark:
                return dark

            @unknown default:
                assertionFailure("Unknown userInterfaceStyle: \(traits.userInterfaceStyle)")
                return any
            }
        }))
        #endif
    }
    #endif

    #if canImport(AppKit)
    private init(any: NSColor, dark: NSColor) {
        self.init(nsColor: NSColor(name: nil, dynamicProvider: { appearance in
            switch appearance.name {
            case .aqua,
                 .vibrantLight,
                 .accessibilityHighContrastAqua,
                 .accessibilityHighContrastVibrantLight:
                return any

            case .darkAqua,
                 .vibrantDark,
                 .accessibilityHighContrastDarkAqua,
                 .accessibilityHighContrastVibrantDark:
                return dark

            default:
                assertionFailure("Unknown appearance: \(appearance.name)")
                return any
            }
        }))
    }
    #endif
}
