//
//  ImageExtension.swift
//
//
//  Created by south.kin on 1/16/24.
//

import Foundation
import SwiftUI
public extension Data {
    var makeImage:Image? {
#if os(iOS)
        return UIImage(data: self).map{Image(uiImage: $0)}
#elseif os(macOS)
        return NSImage(data: self).map{Image(nsImage: $0)}
#endif
    }
}
