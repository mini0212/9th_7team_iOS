//
//  JsonDataProtocol.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/12.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

protocol JsonDataProtocol: Codable, Equatable {
    func toJson() -> String
    static func fromJson<T: JsonDataProtocol>(jsonData: Data?, object: T) -> T?
}

extension JsonDataProtocol {
    func toJson() -> String {
        var jsonString: String = ""
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.outputFormatting = .sortedKeys
        guard let jsonData = try? encoder.encode(self) else {
            return ""
        }
        jsonString = String(data: jsonData, encoding: .utf8) ?? ""
        return jsonString
    }
    
    static func fromJson<T: JsonDataProtocol>(jsonData: Data?, object: T) -> T? {
        var returnValue: T?
        let decoder = JSONDecoder()
        if let data = jsonData, let result = try? decoder.decode(T.self, from: data) {
            returnValue = result
        }
        return returnValue
    }
}
