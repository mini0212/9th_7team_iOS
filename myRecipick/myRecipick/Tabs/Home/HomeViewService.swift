//
//  HomeViewService.swift
//  myRecipick
//
//  Created by hanwe on 2021/06/06.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import SwiftyJSON

protocol HomeViewServiceProtocol: AnyObject {
    var error: PublishSubject<String> { get set }
    func getSampleCustomMenus() -> Observable<RecommendCustomMenus>
}

class HomeViewService: HomeViewServiceProtocol {
    
    // MARK: property
    
    var disposeBag: DisposeBag = DisposeBag()
    var error: PublishSubject<String>
    
    // MARK: lifeCycle
    
    init() {
        self.error = .init()
    }
    
    // MARK: internal function
    
    func getSampleCustomMenus() -> Observable<RecommendCustomMenus> {
        return Observable.create { [weak self] emitter in
            guard let self = self else { return Disposables.create() }
            self.requestRecommandMenus()
                .subscribe(onNext: { responseJson in
                    let itemData = responseJson.rawString()?.data(using: .utf8)
                    if let obj: RecommendCustomMenus = RecommendCustomMenus.fromJson(jsonData: itemData, object: RecommendCustomMenus()) {
                        emitter.onNext(obj)
                    }
                    emitter.onCompleted()
                }, onError: { [weak self] err in
                    self?.error.onNext(err.localizedDescription)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    // MARK: private function
    
    private func requestRecommandMenus() -> Observable<JSON> {
        var httpRequest = HttpRequest()
        httpRequest.url = APIDefine.RECOMMAND_MENUS
        httpRequest.method = .get
        return ServerUtil.shared.rx.requestRxToJson(with: httpRequest, baseUrl: .test)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .default))
            .observe(on: MainScheduler.instance)
            .retry(3)
    }
    
}

struct RecommendCustomMenus: JsonDataProtocol {
    var title: String = ""
    var recommendCustomMenus: [RecommendCustomMenu] = []
}

struct RecommendCustomMenu: JsonDataProtocol {
    var id: String = ""
    var name: String = ""
    var menuName: String = ""
    var imageUrl: String? = ""
    var backgroundColor: String = ""
    var createdDate: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case menuName
        case imageUrl = "image"
        case backgroundColor
        case createdDate
    }
}
