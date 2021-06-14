//
//  APIError.swift
//  myRecipick
//
//  Created by Min on 2021/04/12.
//

import Foundation

struct APIError: Error, Decodable {
    let error: String?
    let message: String?
    let path: String?
    let requestId: String?
    let status: Int?
}
