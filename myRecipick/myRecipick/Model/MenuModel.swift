//
//  MenuModel.swift
//  myRecipick
//
//  Created by Min on 2021/05/14.
//  Copyright © 2021 depromeet. All rights reserved.
//

import Foundation

protocol MenuProtocol {
    var status: Int { get }
    var message: String { get }
    var data: [MenuDataProtocol] { get }
}

protocol MenuDataProtocol {
    var id: String { get }
    var brandId: String { get }
    var name: String { get }
    var image: String { get }
    var isShow: Bool { get }
    var createdDate: String { get }
    var updatedDate: String { get }
}
