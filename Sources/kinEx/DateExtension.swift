//
//  DateExtension.swift
//
//
//  Created by south.kin on 1/13/24.
//

import Foundation
extension Date {
    func stringValue(format:String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
