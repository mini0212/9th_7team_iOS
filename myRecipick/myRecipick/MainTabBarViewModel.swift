//
//  MainTabBarViewModel.swift
//  myRecipick
//
//  Created by hanwe on 2021/06/19.
//  Copyright © 2021 depromeet. All rights reserved.
//

import RxSwift
import SwiftyJSON

protocol MainTabBarViewModelInput {
    func setBrandList()
    func setUniqueUUID()
}

protocol MainTabBarViewModelOutput {
    var error: PublishSubject<String> { get }
    var finishedSetBrandList: PublishSubject<Void> { get }
    var finishedSetUniqueUUID: PublishSubject<Void> { get }
//    var detailCustomMenu: BehaviorSubject<CustomMenuDetailObjModel> { get }
//    var customMenuInfo: BehaviorSubject<CustomMenuObjModel> { get }
//    var allIngredients: BehaviorSubject<[CustomMenuDetailOptionGroupOptionsObjModel]> { get }
}

protocol MainTabBarViewModelType {
    var inputs: MainTabBarViewModelInput { get }
    var outputs: MainTabBarViewModelOutput { get }
}

class MainTabBarViewModel: MVVMViewModel, MainTabBarViewModelInput, MainTabBarViewModelOutput, MainTabBarViewModelType {
    
    // MARK: property
    
    var inputs: MainTabBarViewModelInput {
        return self
    }
    
    var outputs: MainTabBarViewModelOutput {
        return self
    }
    
    var disposeBag: DisposeBag = DisposeBag()
    var error: PublishSubject<String>
    var finishedSetBrandList: PublishSubject<Void>
    var finishedSetUniqueUUID: PublishSubject<Void>
    
    // MARK: lifeCycle
    
    init() {
        self.error = .init()
        self.finishedSetBrandList = .init()
        self.finishedSetUniqueUUID = .init()
    }
    
    func subscribeInputs() {
    }
    
    // MARK: function
    
    func setBrandList() {
        BrandModel.shared.requestBandListRx().subscribe(onNext: { [weak self] items in
            BrandModel.shared.fetchBrandList(items: items)
            self?.outputs.finishedSetBrandList.onNext(())
        }, onError: { [weak self] err in
            self?.outputs.error.onNext(err.localizedDescription)
        })
        .disposed(by: self.disposeBag)
    }
    
    func setUniqueUUID() {
        if UniqueUUIDManager.shared.uniqueUUID != "" { // todo rx로 브랜드 가져오기 쿼리랑 묶어버리기
            self.finishedSetUniqueUUID.onNext(())
        } else {
            UniqueUUIDManager.shared.registAndSaveUUID(completeHandler: { [weak self] in
                self?.outputs.finishedSetUniqueUUID.onNext(())
            }, failureHandler: { [weak self] errMsg in
                self?.outputs.error.onNext(errMsg)
            })
        }
    }

}
