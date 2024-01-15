//
//  Neu.swift
//
//
//  Created by south.kin on 1/14/24.
//

import Foundation
import SwiftUI

public struct NeuModifier: ViewModifier {
    public enum NeuStyle {
        case neuRaised, neuPressed, reflectedLight
    }
    var lightColor:Color
    var shadowColor:Color
    var depth: CGFloat
    var style: NeuStyle

    public func body(content: Content) -> some View {
        let d = max(-3,min(3,depth))
        switch style {
        case .neuRaised:
            return AnyView(content
                .maskedShadow(type: .outer,
                              color: lightColor,
                              radius: abs(d)*1.2,
                              x: -d*0.8,
                              y:-d*0.8)
                    .maskedShadow(type: .outer,
                                  color: shadowColor,
                                  radius: abs(d)*1.2,
                                  x: d*0.8,
                                  y: d*0.8)
            )
        case .neuPressed:
            return AnyView(content
                .maskedShadow(type: .inner,
                              color: lightColor,
                              radius: abs(d)*1.2,
                              x: d*0.8,
                              y: d*0.8)
            )
        case .reflectedLight:
            return AnyView( content
                .maskedShadow(type: .reflectLight,
                              color: lightColor,
                              radius: abs(d)*1.2)
            )
        }
    }
}


public extension View {
    func neu(style: NeuModifier.NeuStyle, lightColor:Color = .white.opacity(0.8), shadowColor:Color = .black.opacity(0.7), depth: CGFloat = 1.5) -> some View {
        self.modifier(NeuModifier(lightColor: lightColor, shadowColor: shadowColor, depth: depth, style: style))
    }
}
public extension Image {
    func neu(style: NeuModifier.NeuStyle, foregroundColor:Color, lightColor:Color = .white.opacity(0.8), shadowColor:Color = .black.opacity(0.7), depth: CGFloat = 1.5) -> Image {
        
        if #available(iOS 15, macOS 12, *) {
            return self.renderingMode(.template)
                .foregroundStyle(foregroundColor)
                .neu(style: style,lightColor: lightColor,shadowColor: shadowColor,depth: depth) as! Image
        } else {
            return self.renderingMode(.template)
                .foregroundColor(foregroundColor)
                .neu(style: style,lightColor: lightColor,shadowColor: shadowColor,depth: depth) as! Image
        }
            
    }
}