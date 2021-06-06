//
//  APIDefine.swift
//  myRecipick
//
//  Created by hanwe on 2021/04/19.
//  Copyright © 2021 depromeet. All rights reserved.
//

class APIDefine {
    enum BaseUrl: String {
        case v1 = "https://api.myrecipick.com/v1/"
        case test = "https://test-api.myrecipick.com/"
        
        func getUrlString() -> String {
            return self.rawValue
        }
    }
    
    static let GET_BRANDS: String = "brands"
    static let REGIST_USER: String = "users"
    static let MY_CUSTOM_MENUS: String = "my/custom-menus"
    static let MY_CUSTOM_MENU_DETAIL: String = "my/custom-menus"
    static let REQUEST_NEW_BRAND: String = "help/request-brands"
    static let RECOMMAND_MENUS: String = "home"
}
