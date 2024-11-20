//
//  FontSize.swift
//
//
//  Created by Jiafu Zhang on 3/16/24.
//

import SwiftUI

public struct Typography: ViewModifier {
    public enum FontSize {
        case extraSmall
        case small
        case base
        case large
        case extraLarge
        case extraLarge2
        case extraLarge3
        case extraLarge4
        case extraLarge5
        case extraLarge6
        case extraLarge7
        case extraLarge8
        case extraLarge9
        
        var fontSize: CGFloat {
            switch self {
            case .extraSmall:
                .rem(0.75)
            case .small:
                .rem(0.875)
            case .base:
                .rem(1)
            case .large:
                .rem(1.125)
            case .extraLarge:
                .rem(1.25)
            case .extraLarge2:
                .rem(1.5)
            case .extraLarge3:
                .rem(1.875)
            case .extraLarge4:
                .rem(2.25)
            case .extraLarge5:
                .rem(3)
            case .extraLarge6:
                .rem(3.75)
            case .extraLarge7:
                .rem(4.5)
            case .extraLarge8:
                .rem(6)
            case .extraLarge9:
                .rem(8)
            }
        }
        
        var lineHeight: CGFloat? {
            switch self {
            case .extraSmall:
                .rem(1)
            case .small:
                .rem(1.25)
            case .base:
                .rem(1.5)
            case .large:
                .rem(1.75)
            case .extraLarge:
                .rem(1.75)
            case .extraLarge2:
                .rem(2)
            case .extraLarge3:
                .rem(2.25)
            case .extraLarge4:
                .rem(2.5)
            default:
                nil
            }
        }
    }
    
    let fontSize: FontSize
    let lineHeight: CGFloat?
    
    public func body(content: Content) -> some View {
        content
            .font(.system(size: fontSize.fontSize))
            .if(lineHeight != nil, transform: { view in
                view
//                    .padding(.vertical, (lineHeight! - fontSize.fontSize) / 2)
                    .lineHeight(lineHeight!, fontSize: fontSize.fontSize)
            })
    }
}

public extension ViewModifier where Self == Typography {
    static func text(_ fontSize: Typography.FontSize) -> Self {
        Self(fontSize: fontSize, lineHeight: fontSize.lineHeight)
    }
}

public struct LineHeight: ViewModifier {
    let lineHeight: CGFloat
    let fontSize: CGFloat
    
    public func body(content: Content) -> some View {
        content
            .lineSpacing((lineHeight - fontSize) / 2)
    }
}

public extension ViewModifier where Self == LineHeight {
    static func lineHeight(_ lineHeight: CGFloat, fontSize: CGFloat) -> Self {
        LineHeight(lineHeight: lineHeight, fontSize: fontSize)
    }
}

public extension View {
    func text(_ fontSize: Typography.FontSize) -> some View {
        modifier(.text(fontSize))
    }
    
    func lineHeight(_ lineHeight: CGFloat, fontSize: CGFloat) -> some View {
        modifier(.lineHeight(lineHeight, fontSize: fontSize))
    }
}
