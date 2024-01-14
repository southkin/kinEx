//
//  DateExtension.swift
//
//
//  Created by south.kin on 1/13/24.
//

import Foundation
public extension Date {
    var string:String {
        stringValue(format: "yyyy-MM-dd HH:mm:ss")
    }
    func stringValue(format:String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
