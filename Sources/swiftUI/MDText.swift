//
//  MDText.swift
//
//
//  Created by south.kin on 1/16/24.
//

import SwiftUI
struct MDText: View {
    var text:String
    var body: some View {
        
        if #available(macOS 12, iOS 15, *) {
            if let attributedString = try? AttributedString(markdown: text, options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)) {
                Text(attributedString)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
            }
            else {
                Text(text)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
            }
        } else {
            Text(text)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
        }
        
    }
    init(_ text: String) {
        self.text = text
    }
}

#Preview {
    MDText("test **test**")
}
