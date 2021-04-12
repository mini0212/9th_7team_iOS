//
//  APIError.swift
//  myRecipick
//
//  Created by Min on 2021/04/12.
//

import Foundation

struct APIError: Error, Decodable {
    let error: ErrorMessage
}

struct ErrorMessage: Error, Decodable {
    let message: String
    let name: Int
    
    init(message: String,
         name: Int) {
        self.message = message
        self.name = name
    }
}
