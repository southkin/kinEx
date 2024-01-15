//
//  ColorExtension.swift
//
//
//  Created by south.kin on 1/16/24.
//

import Foundation
import SwiftUI
public extension Color {
    static var systemBackgroundColor:Color {
#if os(iOS)
        if #available(iOS 15, *) {
            Color(uiColor: UIColor.systemBackground)
        }
        else {
            Color(UIColor.systemBackground)
        }
#elseif os(macOS)
        if #available(macOS 12, *) {
            Color(nsColor: NSColor.windowBackgroundColor)
        }
        else {
            Color(NSColor.windowBackgroundColor)
        }
#endif
    }
}
