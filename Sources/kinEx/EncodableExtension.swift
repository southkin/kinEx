//
//  EncodableExtension.swift
//
//
//  Created by south.kin on 1/13/24.
//

import Foundation
public extension Encodable {
    var allProperties:[(String,Encodable?)] {
        var result = [(String,Encodable?)]()
        let mirror = Mirror(reflecting: self)
        guard let style = mirror.displayStyle, style == .struct || style == .class else {
            return []
        }
        for (property, value) in mirror.children {
            if let p = property {
                result.append((p,value as? Encodable))
            }
        }
        return result
    }
    var JSONString:String? {
        return self.data.string()
    }
    var data:Data {
        guard let data = try? JSONEncoder().encode(self) else {
            return Data()
        }
        return data
    }
}
