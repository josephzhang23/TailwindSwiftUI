//
//  BorderWidth.swift.swift
//
//
//  Created by Jiafu Zhang on 3/16/24.
//

import SwiftUI

public struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: Edge.Set
    var style = Style.solid
    var cornerRadius: CGFloat = 0

    public func path(in rect: CGRect) -> Path {
        let path: Path
        let pattern = style.makePattern()
        
        switch edges {
        case .all: path = Path(CGPath(roundedRect: rect, cornerWidth: cornerRadius, cornerHeight: cornerRadius, transform: nil))
        case .top: path = Path(.init(x: rect.minX, y: rect.minY, width: rect.width, height: width))
        case .bottom: path = Path(.init(x: rect.minX, y: rect.maxY - width, width: rect.width, height: width))
        case .horizontal: path = Path(.init(x: rect.minX, y: rect.midY - width / 2, width: rect.width, height: width))
        case .leading: path = Path(.init(x: rect.minX, y: rect.minY, width: width, height: rect.height))
        case .trailing: path = Path(.init(x: rect.maxX - width, y: rect.minY, width: width, height: rect.height))
        case .vertical: path = Path(.init(x: rect.midX - width / 2, y: rect.minY, width: width, height: rect.height))
        default: path = Path()
        }
        
        return path.strokedPath(.init(lineWidth: width, lineCap: .square, lineJoin: .miter, dash: pattern, dashPhase: 0))
    }
}

public struct Border: ViewModifier {
    let content: AnyShapeStyle
    let width: CGFloat
    let edges: Edge.Set
    var style = EdgeBorder.Style.solid
    var rounded = BorderRadius.Size.none
    
    public func body(content: Content) -> some View {
        let width = style == .double ? width / 3 : width
        let border = EdgeBorder(width: width, edges: edges, style: style, cornerRadius: rounded.cornerRadius).fill(self.content)
        var view = AnyView(content.overlay(border))
        if style == .double {
            view = AnyView(view.padding(width * 2).overlay(border))
        }
        return view
    }
}

public extension ViewModifier where Self == AnyViewModifier {
    static func border(_ content: some ShapeStyle, _ edges: Edge.Set = .all) -> Self {
        AnyViewModifier(Border(content: AnyShapeStyle(content), width: 1, edges: edges))
    }
}

public extension ViewModifier where Self == AnyViewModifier {
    static func border(_ style: EdgeBorder.Style, _ content: some ShapeStyle, _ edges: Edge.Set = .all, width: CGFloat = 1, rounded: BorderRadius.Size) -> Self {
        Self(Border(content: AnyShapeStyle(content), width: width, edges: edges, style: style, rounded: rounded))
    }
    
    static func border(_ content: some ShapeStyle, _ edges: Edge.Set = .all, width: CGFloat = 1, rounded: BorderRadius.Size = .none) -> Self {
        Self(Border(content: AnyShapeStyle(content), width: width, edges: edges, rounded: rounded))
    }
}

public extension View {
    func border(_ edges: Edge.Set = .all) -> some View {
        overlay(EdgeBorder(width: 1, edges: edges))
    }
    
    func border(_ content: some ShapeStyle = .black, _ edges: Edge.Set, width: CGFloat = 1) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).fill(content))
    }
    
    func border(_ content: some ShapeStyle = .black, width: CGFloat = 1, rounded: BorderRadius.Size = .none) -> some View {
        border(.solid, content, width: width, rounded: rounded)
    }
    
    func border(_ style: EdgeBorder.Style, _ content: some ShapeStyle = .black, width: CGFloat = 1, rounded: BorderRadius.Size = .none) -> some View {
        let width = style == .double ? width / 3 : width
        let border = EdgeBorder(width: width, edges: .all, style: style, cornerRadius: rounded.cornerRadius).fill(content)
        var view = AnyView(overlay(border))
        if style == .double {
            view = AnyView(view.padding(width * 2).overlay(border))
        }
        return view
    }
}
