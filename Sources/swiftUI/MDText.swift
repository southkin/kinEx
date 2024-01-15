//
//  MDText.swift
//
//
//  Created by south.kin on 1/16/24.
//

import SwiftUI
public struct MDText: View {
    var text:String
    public var body: some View {
        let t:LocalizedStringKey = .init(text)
        return Text(t)
    }
    public init(_ text: String) {
        self.text = text
    }
}

#Preview {
    MDText("""
test    **link**[apple](https://apple.com)
# ㄹㄷㅈㄹ
ㄹㄷㅈ러ㅐㅑㅓ
```
**fef**
```
- ㅁㄴㅇㄹ
    - asdf
        - 1rf
    - asdf
1. ㅈㄷㄹ
1. ㄹㅁㅈㄷㄹ
1. ㅅㄷㄴㅅ
>ㄹㅈㄷㄹ
>렂댜ㅐㄹ
>럳재ㅑㄹ
""").multilineTextAlignment(.leading)
}
