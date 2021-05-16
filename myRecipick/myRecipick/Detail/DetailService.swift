//
//  DetailService.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/05/06.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class DetailService: NSObject {
    deinit {
        print("- \(type(of: self)) deinit")
    }
}

struct CustomMenuDetailObjModel: JsonDataProtocol {
    var id: String = ""
    var userId: String = ""
    var menuId: String = ""
    var name: String = ""
    var optionGroups: [CustomMenuDetailOptionGroupObjModel] = []
    var createdDate: String = ""
    var updatedDate: String = ""
    var isShow: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case menuId
        case name
        case optionGroups
        case createdDate
        case updatedDate
        case isShow = "show"
    }
}

struct CustomMenuDetailOptionGroupObjModel: JsonDataProtocol {
    var id: String = ""
    var type: String = ""
    var name: String = ""
    var imageUrl: String?
    var options: [CustomMenuDetailOptionGroupOptionsObjModel] = []
    var policy: CustomMenuDetailOptionGroupPolicyObjModel = CustomMenuDetailOptionGroupPolicyObjModel()
    var createdDate: String?
    var updatedDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case name
        case imageUrl = "image"
        case options
        case policy
        case createdDate
        case updatedDate
    }
}

struct CustomMenuDetailOptionGroupOptionsObjModel: JsonDataProtocol {
    var type: String = ""
    var name: String = ""
    var imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case type
        case name
        case imageUrl = "image"
    }
}

struct CustomMenuDetailOptionGroupPolicyObjModel: JsonDataProtocol {
    var min: Int = -1
    var max: Int = -1
}
