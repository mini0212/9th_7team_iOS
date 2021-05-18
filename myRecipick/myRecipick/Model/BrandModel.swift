//
//  BrandModel.swift
//  myRecipick
//
//  Created by hanwe on 2021/04/19.
//  Copyright © 2021 depromeet. All rights reserved.
//

import Alamofire
import SwiftyJSON

class BrandModel {
    
    // MARK: property
    
    private let serverUtil = ServerUtil.shared
    
    var selectedIndex: Int = -1
    var brands: [BrandObjectModel] = []
    
    // MARK: lifeCycle
    
    func initFunc() {
        
    }
    
    // MARK: function
    
    static let shared: BrandModel = {
        let instance = BrandModel()
        instance.initFunc()
        return instance
    }()
    
    func requestBandList(completeHandler: @escaping (JSON) -> Void, failureHandler: @escaping (Error) -> Void) {
        let httpRequest: HttpRequest = HttpRequest(url: APIDefine.GET_BRANDS, method: .get, parameters: nil, headers: .default, encoding: .jsonDefault)
        ServerUtil.shared.request(with: httpRequest) { (responseJson) in
            completeHandler(responseJson)
        } failure: { (err) in
            failureHandler(err)
        }
    }
    
    func fetchBrandList(items: JSON) {
        self.brands.removeAll()
        self.selectedIndex = -1
        for i in 0..<items.count {
            let item: JSON = items[i]
            let itemData = item.rawString()?.data(using: .utf8)
            if let item: BrandObjectModel = BrandObjectModel.fromJson(jsonData: itemData, object: BrandObjectModel()) {
                self.brands.append(item)
            }
        }
        if self.brands.count > 0 {
            self.selectedIndex = 0
        }
    }
    
    func getCurrentBrandInfo() -> BrandObjectModel {
        return self.brands[self.selectedIndex]
    }
    
    func getCurrentBrandId() -> String {
        return self.getCurrentBrandInfo().brandId
    }
    
    func getCurrentBrandName() -> String {
        return self.getCurrentBrandInfo().name
    }
    
    func getCurrentBrandLogoImageUrl() -> String {
        return self.getCurrentBrandInfo().logoImgUrl
    }
    
    func getCurrentBrandIsShow() -> Bool {
        return self.getCurrentBrandInfo().isShow
    }
}

struct BrandObjectModel: JsonDataProtocol {
    
    var brandId: String = ""
    var name: String = ""
    var isShow: Bool = false
    var logoImgUrl: String = ""
    
    enum CodingKeys: String, CodingKey {
        case brandId = "id"
        case name
        case logoImgUrl = "logoImage"
        case isShow
    }
}
