//
//  YourPageService.swift
//  myRecipick
//
//  Created by hanwe on 2021/05/02.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import SwiftyJSON

protocol YourPageServiceProtocol {
    var error: PublishSubject<String> { get set }
    func getYourCustomMenus() -> Observable<[CustomMenuObjModel]>
}

class YourPageService: YourPageServiceProtocol {
    
    // MARK: property
    
    var disposeBag: DisposeBag = DisposeBag()
    var error: PublishSubject<String>
    
    // MARK: lifeCycle
    
    init() {
        self.error = .init()
    }
    
    // MARK: function
    
    func getYourCustomMenus() -> Observable<[CustomMenuObjModel]> {
        return Observable.create { [weak self] emitter in
            guard let self = self else { return Disposables.create() }
            self.requestYourCustomMenus()
                .subscribe(onNext: { [weak self] responseJson in
                    var items: [CustomMenuObjModel] = []
                    for i in 0..<responseJson.count {
                        let item: JSON = responseJson[i]
                        let itemData = item.rawString()?.data(using: .utf8)
                        if let obj: CustomMenuObjModel = CustomMenuObjModel.fromJson(jsonData: itemData, object: CustomMenuObjModel()) {
                            items.append(obj)
                        }
                    }
                    emitter.onNext(items)
                    emitter.onCompleted()
                }, onError: { [weak self] err in
                    self?.error.onNext(err.localizedDescription)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    // MARK: private function
    
    private func requestYourCustomMenus() -> Observable<JSON> {
        var httpRequest = HttpRequest()
        httpRequest.url = APIDefine.MY_CUSTOM_MENUS
        httpRequest.headers = .customMenus(uniqueId: UniqueUUIDManager.shared.uniqueUUID)
        return ServerUtil.shared.rx.requestRxToJson(with: httpRequest)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .default))
            .observe(on: MainScheduler.instance)
            .retry(3)
    }
    
}

struct CustomMenuObjModel: JsonDataProtocol {
    var id: String = ""
    var brandId: String = ""
    var name: String = ""
    var description: String = ""
    var imageUrl: String?
    var isShow: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case brandId
        case name
        case description
        case imageUrl = "image"
        case isShow
    }
}
