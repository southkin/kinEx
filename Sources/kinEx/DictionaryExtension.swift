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
    var markdown:String {
        return convertToMarkdown(from: self)
    }
    fileprivate func convertToMarkdown(from dictionary: [String: Any], indentLevel: Int = 0) -> String {
        var markdownString = ""
        let indent = String(repeating: "    ", count: indentLevel)
        for (key, value) in dictionary {
            if let subDictionary = value as? [String: Any] {
                markdownString += "\(indent)- ***\(key)***:\n" + convertToMarkdown(from: subDictionary, indentLevel: indentLevel + 1)
            } else if let array = value as? [Any] {
                markdownString += "\(indent)- *\(key)*:\n"
                for item in array.enumerated() {
                    markdownString += "\(indent)  *\(item.offset+1).* \(item.element)\n"
                }
            } else {
                markdownString += "\(indent)- *\(key)*: `\(value)`\n"
            }
        }
        return markdownString
    }

}
