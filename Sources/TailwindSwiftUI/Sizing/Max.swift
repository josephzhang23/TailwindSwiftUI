//
//  Max.swift
//  Utilities for setting the maximum dimension of an element.
//
//  Created by Jiafu Zhang on 3/23/24.
//

import SwiftUI

public struct Max: ViewModifier {
    public enum Scale {
        case none
        case extraSmall
        case small
        case medium
        case large
        case extraLarge
        case extraLarge2
        case extraLarge3
        case extraLarge4
        case extraLarge5
        case extraLarge6
        case extraLarge7
        case full
        
        var size: CGFloat? {
            switch self {
            case .none:
                nil
            case .extraSmall:
                20
            case .small:
                24
            case .medium:
                28
            case .large:
                32
            case .extraLarge:
                36
            case .extraLarge2:
                42
            case .extraLarge3:
                48
            case .extraLarge4:
                56
            case .extraLarge5:
                64
            case .extraLarge6:
                72
            case .extraLarge7:
                80
            case .full:
                .infinity
            }
        }
        
        var pixels: CGFloat? {
            if let size {
                .rem(size)
            } else {
                size
            }
        }
    }
    
    let maxWidth: CGFloat?
    let alignment: Alignment
    
    public func body(content: Content) -> some View {
        content
            .frame(maxWidth: maxWidth, alignment: alignment)
    }
}

public extension View {
    func max(width: Scale, alignment: Alignment = .center) -> some View {
        modifier(Max(maxWidth: .scale(width), alignment: alignment))
    }
    
    func max(width: Max.Scale, alignment: Alignment = .center) -> some View {
        modifier(Max(maxWidth: width.pixels, alignment: alignment))
    }
}

public extension ViewModifier where Self == Max {
    static func max(width: Max.Scale, alignment: Alignment = .center) -> Self {
        Max(maxWidth: width.pixels, alignment: alignment)
    }
}
