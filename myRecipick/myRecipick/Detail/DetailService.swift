//
//  DetailService.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/05/06.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit
import RxSwift

protocol DetailServiceProtocol {
    func getObservableDetailInfo() -> Observable<CustomMenuDetailObjModel>
    func getObservableCustomMenu() -> Observable<CustomMenuObjModel>
}

class DetailService: DetailServiceProtocol {
    
    struct DetailServiceInfoModel {
        let customMenuDetailObjModel: CustomMenuDetailObjModel
        let customMenuObjModel: CustomMenuObjModel
    }
    
    // MARK: property
    
    private var infoData: DetailService.DetailServiceInfoModel
    
    // MARK: lifeCycle
    
    init(data: DetailServiceInfoModel) {
        self.infoData = data
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    // MARK: function
    
    func getObservableDetailInfo() -> Observable<CustomMenuDetailObjModel> {
        return Observable.create { [weak self] emitter in
            guard let self = self else { return Disposables.create() }
            emitter.onNext(self.infoData.customMenuDetailObjModel)
            emitter.onCompleted()
            return Disposables.create()
        }
    }
    
    func getObservableCustomMenu() -> Observable<CustomMenuObjModel> {
        return Observable.create { [weak self] emitter in
            guard let self = self else { return Disposables.create() }
            emitter.onNext(self.infoData.customMenuObjModel)
            emitter.onCompleted()
            return Disposables.create()
        }
    }
}

struct CustomMenuDetailObjModel: JsonDataProtocol {
    var id: String = ""
    var userId: String = ""
    var name: String = ""
    var optionGroups: [CustomMenuDetailOptionGroupObjModel] = []
    var menu: CustomMenuDetailOriginalMenuObjModel?
    var createdDate: String = ""
    var updatedDate: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case name
        case optionGroups
        case menu
        case createdDate
        case updatedDate
    }
}

struct CustomMenuDetailOptionGroupObjModel: JsonDataProtocol {
    var id: String = ""
    var name: String = ""
    var imageUrl: String?
    var options: [CustomMenuDetailOptionGroupOptionsObjModel] = []
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "image"
        case options
    }
}

struct CustomMenuDetailOriginalMenuObjModel: JsonDataProtocol {
    var id: String = ""
    var name: String = ""
    var imageUrl: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "image"
    }
}

struct CustomMenuDetailOptionGroupOptionsObjModel: JsonDataProtocol {
    var name: String = ""
    var imageUrl: String?
    var category: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageUrl = "image"
        case category
    }
}
