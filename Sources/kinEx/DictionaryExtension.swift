//
//  File.swift
//  
//
//  Created by south.kin on 1/14/24.
//

import Foundation
public extension Dictionary where Key == String, Value == Any {
    var data:Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: [])
    }
}
