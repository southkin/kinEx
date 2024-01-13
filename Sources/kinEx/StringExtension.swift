//
//  StringExtension.swift
//  
//
//  Created by south.kin on 1/13/24.
//

import Foundation


public extension String {
    func urlEncode(_ chars:CharacterSet = .urlQueryAllowed) -> String? {
        self.addingPercentEncoding(withAllowedCharacters: chars)
    }
    public var dict:[String:Any]? {
        makeJsonObj()
    }
    func makeJsonObj<T>() -> T? {
        guard let data = self.data(using: .utf8) else {return nil}
        return try? JSONSerialization.jsonObject(with: data) as? T
    }
    func makeObj<T:Decodable>() -> T? {
        guard let data = self.data(using: .utf8) else {return nil}
        return try? JSONDecoder().decode(T.self, from: data)
    }
    func makeObj<T:Decodable>(t:T.Type) -> T? {
        guard let data = self.data(using: .utf8) else {return nil}
        return try? JSONDecoder().decode(T.self, from: data)
    }
    var fullRange: NSRange {
        return NSRange(location: 0, length: self.count)
    }
    func regex(pattern:String,options:NSRegularExpression.Options,_ block:(NSTextCheckingResult?, NSRegularExpression.MatchingFlags, UnsafeMutablePointer<ObjCBool>) -> Void) {
        let reg = try? NSRegularExpression(pattern: pattern, options: options)
        reg?.enumerateMatches(in: self, options: [], range: fullRange){ result, flags, stop in
            block(result,flags,stop)
        }
        
    }
    func matches(pattern:String,with name:String?) -> [String]? {
        let regex = try? NSRegularExpression(pattern: pattern)
        let result = regex?.matches(in: self, range: fullRange)
        return result?.map({ (ele) -> String? in
            var range:NSRange?
            if let name = name {
                range = ele.range(withName: name)
            }
            else {
                range = ele.range
            }
            guard let r = range else {return nil}
            return (self as NSString).substring(with: r)
        }).compactMap{$0}
    }
    func matches(pattern:String, with names:[String]) -> [[String:String]] {
        var list = [[String:String]]()
        let regex = try? NSRegularExpression(pattern: pattern)
        let result = regex?.matches(in: self, range: fullRange)
        result?.forEach { match in
            var item = [String:String]()
            item[""] = (self as NSString).substring(with: match.range)
            names.forEach {
                item[$0] = (self as NSString).substring(with: match.range(withName: $0))
            }
            list.append(item)
        }
        return list
    }
    var makeURL:URL? {
        return URL(string: self)
    }
    func replace(pattern:String, replaceWith:String = "") -> String {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let range = NSMakeRange(0, self.count)
            return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replaceWith)
        } catch {
            print(error)
            return self
        }
    }
    func index(at offset: Int) -> String.Index {
        index(startIndex, offsetBy: offset)
    }
    subscript(_ index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
    subscript(_ range: CountableClosedRange<Int>) -> String {
        String(self[index(at: max(0, range.lowerBound))...index(at: min(self.count, range.upperBound))])
    }
    
    subscript(_ range: CountableRange<Int>) -> String {
        String(self[index(at: max(0, range.lowerBound))..<index(at: min(self.count, range.upperBound))])
    }
    
    subscript(_ range: PartialRangeUpTo<Int>) -> String {
        String(self[..<index(at: min(self.count, range.upperBound))])
    }
    
    subscript(_ range: PartialRangeThrough<Int>) -> String {
        String(self[...index(at: min(self.count, range.upperBound))])
    }
    
    subscript(_ range: PartialRangeFrom<Int>) -> String {
        String(self[index(at: max(0, range.lowerBound))...])
    }
    static func random(length:Int = 20)->String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".map {
            return String($0)
        }
        var randomString: String = ""
        for _ in 0..<length {
            randomString += base.randomElement()!
        }
        return randomString
    }
    var version:Version {
        .init(version: self)
    }
    var intValue:Int? {
        .init(self)
    }
    var UIntValue:UInt? {
        .init(self)
    }
    var localized:String {
        return NSLocalizedString(self, comment: "")
    }
    func localized(comment:String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    func localized(with argument:CVarArg..., comment:String = "") -> String {
        return String(format: self.localized(comment: comment), argument)
    }
}
public struct Version : Equatable {
    var version:String
}
public extension Version {
    static func ==(lhs: Version, rhs: Version) -> Bool {
        return lhs.version.compare(rhs.version, options: .numeric) == .orderedSame
    }
    
    static func <(lhs: Version, rhs: Version) -> Bool {
        return lhs.version.compare(rhs.version, options: .numeric) == .orderedAscending
    }
    
    static func <=(lhs: Version, rhs: Version) -> Bool {
        return lhs.version.compare(rhs.version, options: .numeric) == .orderedAscending || lhs.version.compare(rhs.version, options: .numeric) == .orderedSame
    }
    
    static func >(lhs: Version, rhs: Version) -> Bool {
        return lhs.version.compare(rhs.version, options: .numeric) == .orderedDescending
    }
    
    static func >=(lhs: Version, rhs: Version) -> Bool {
        return lhs.version.compare(rhs.version, options: .numeric) == .orderedDescending || lhs.version.compare(rhs.version, options: .numeric) == .orderedSame
    }
}
