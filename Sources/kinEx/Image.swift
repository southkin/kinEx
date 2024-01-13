//
//  Image.swift
//  
//
//  Created by south.kin on 1/13/24.
//

import Foundation
import Then
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public extension String {
#if os(iOS)
    var qrCode:UIImage? {
        let data = self.data(using: String.Encoding.ascii)
        guard let filter = CIFilter(name: "CIQRCodeGenerator")?.then({ $0.setValue(data, forKey: "inputMessage")}),
              let output = filter.outputImage?.transformed(by: CGAffineTransform(scaleX: 3, y: 3)) else {return nil}
        return UIImage(ciImage: output)
    }
#elseif os(macOS)
    var qrCode:NSImage? {
        let data = self.data(using: String.Encoding.ascii)
        guard let filter = CIFilter(name: "CIQRCodeGenerator")?.then({ $0.setValue(data, forKey: "inputMessage")}),
              let output = filter.outputImage?.transformed(by: CGAffineTransform(scaleX: 3, y: 3)) else {return nil}
        let rep = NSCIImageRep(ciImage: output)
        let nsImage = NSImage(size: rep.size)
        nsImage.addRepresentation(rep)
        return nsImage
    }
#endif
}
