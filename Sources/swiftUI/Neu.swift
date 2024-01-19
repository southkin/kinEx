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
    var radiusRatio:CGFloat
    var offsetRatio:CGFloat

    public func body(content: Content) -> some View {
        let d = max(-3,min(3,depth))
        switch style {
        case .neuRaised:
            return AnyView(content
                .maskedShadow(type: .outer,
                              color: lightColor,
                              radius: abs(d)*radiusRatio,
                              x: -d*offsetRatio,
                              y:-d*offsetRatio)
                    .maskedShadow(type: .outer,
                                  color: shadowColor,
                                  radius: abs(d)*radiusRatio,
                                  x: d*offsetRatio,
                                  y: d*offsetRatio)
            )
        case .neuPressed:
            return AnyView(content
                .maskedShadow(type: .inner,
                              color: lightColor,
                              radius: abs(d)*radiusRatio,
                              x: d*offsetRatio,
                              y: d*offsetRatio)
            )
        case .reflectedLight:
            return AnyView( content
                .maskedShadow(type: .reflectLight,
                              color: lightColor,
                              radius: abs(d))
            )
        }
    }
}


public extension View {
    func neu(style: NeuModifier.NeuStyle, lightColor:Color = .white.opacity(0.8), shadowColor:Color = .black.opacity(0.7), depth: CGFloat = 1.5, radiusRatio:CGFloat = 1, offsetRatio:CGFloat = 1) -> some View {
        self.modifier(NeuModifier(lightColor: lightColor, shadowColor: shadowColor, depth: depth, style: style, radiusRatio: radiusRatio, offsetRatio: offsetRatio))
    }
}
public extension Image {
    func neu(style: NeuModifier.NeuStyle, foregroundColor:Color, lightColor:Color = .white.opacity(0.8), shadowColor:Color = .black.opacity(0.7), depth: CGFloat = 1.5, radiusRatio:CGFloat = 1, offsetRatio:CGFloat = 1) -> Image {
        
        if #available(iOS 15, macOS 12, *) {
            return self.renderingMode(.template)
                .foregroundStyle(foregroundColor)
                .neu(style: style,lightColor: lightColor,shadowColor: shadowColor,depth: depth,radiusRatio: radiusRatio, offsetRatio: offsetRatio) as! Image
        } else {
            return self.renderingMode(.template)
                .foregroundColor(foregroundColor)
                .neu(style: style,lightColor: lightColor,shadowColor: shadowColor,depth: depth,radiusRatio: radiusRatio, offsetRatio: offsetRatio) as! Image
        }
            
    }
}
