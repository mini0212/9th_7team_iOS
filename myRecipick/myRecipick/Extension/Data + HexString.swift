//
//  Data + HexString.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/12.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return self.map { String(format: format, $0) }.joined()
    }
}
