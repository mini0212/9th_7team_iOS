//
//  Encodable + Extensions.swift
//  myRecipick
//
//  Created by Min on 2021/05/29.
//  Copyright © 2021 depromeet. All rights reserved.
//

import Foundation

extension Encodable {
    var toJSONString: String {
        let jsonData = try? JSONEncoder().encode(self)
        if let jsonData = jsonData,
           let jsonString = String(data: jsonData, encoding: .utf8) {
            return jsonString
        }
        return ""
    }
}
