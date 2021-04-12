//
//  JSONConverter.swift
//  myRecipick
//
//  Created by Min on 2021/04/12.
//

import Foundation

struct JSONConverter {
    static func decode<T: Decodable>(from result: Any?) -> T? {
        guard let result = result else { return nil }
        let decodedData: T
        
        do {
            let data = try JSONSerialization.data(withJSONObject: result)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decodedData = try decoder.decode(T.self, from: data)
        } catch {
            print("JSON Decoding Error: \(error)")
            return nil
        }
        return decodedData
    }
}
