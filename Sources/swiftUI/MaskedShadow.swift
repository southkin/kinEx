//
//  File.swift
//  
//
//  Created by south.kin on 1/14/24.
//

import Foundation
import SwiftUI
public struct MaskedShadow: ViewModifier {
    public enum ShadowType {
        case inner
        case outer
        case reflectLight
    }
    var type: ShadowType
    var color: Color = .black
    var radius: CGFloat
    var x: CGFloat
    var y: CGFloat

    public func body(content: Content) -> some View {
        switch type {
        case .inner:
            print("작업예정")
            return AnyView(
                content
            )
        case .outer:
            return AnyView(
                content
                    .shadow(color: color, radius: radius, x: x, y: y)
            )
        case .reflectLight:
            return AnyView(content
                .overlay(
                    content
                        .foregroundColor(.clear)
                        .background(content)
                        .shadow(color: color, radius: radius)
                        .offset(x: x, y: y)
                        .blur(radius: radius)
                        .mask(content)
                )
            )
        }
    }
}

public extension View {
    func maskedShadow(type:MaskedShadow.ShadowType, color:Color = .black, radius:CGFloat, x:CGFloat = 3, y:CGFloat = 3) -> some View {
        self.modifier(MaskedShadow(type: type, color: color, radius: radius, x: x, y: y))
        
    }
}
