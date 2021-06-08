//
//  HomeViewModel.swift
//  myRecipick
//
//  Created by hanwe on 2021/04/18.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit
import RxSwift

protocol HomeViewModelInput {
    func requestRecommendCustomMenus()
    func requestDetailCustomMenuDataAtIndex(index: Int)
}

protocol HomeViewModelOutput {
    var error: PublishSubject<String> { get }
    var isLoading: PublishSubject<Bool> { get }
    var mainTitle: BehaviorSubject<String> { get }
    var recommendCustomMenus: BehaviorSubject<[RecommendCustomMenu]> { get }
    var presentedDetailCustomMenuData: PublishSubject<HomeViewModel.RecommendDetailViewInfoModel> { get }
}

protocol HomeViewModelType {
    var inputs: HomeViewModelInput { get }
    var outputs: HomeViewModelOutput { get }
}

class HomeViewModel: MVVMViewModel, HomeViewModelType, HomeViewModelInput, HomeViewModelOutput {
    
    struct RecommendDetailViewInfoModel {
        let detailServiceInfoModel: DetailService.DetailServiceInfoModel
        let backgroundColor: UIColor
    }
    // MARK: property
    var inputs: HomeViewModelInput {
        return self
    }
    var outputs: HomeViewModelOutput {
        return self
    }
    var service: HomeViewServiceProtocol
    var disposeBag: DisposeBag = DisposeBag()
    var error: PublishSubject<String>
    var isLoading: PublishSubject<Bool>
    var mainTitle: BehaviorSubject<String>
    var recommendCustomMenus: BehaviorSubject<[RecommendCustomMenu]>
    var presentedDetailCustomMenuData: PublishSubject<HomeViewModel.RecommendDetailViewInfoModel>
    
    // MARK: lifeCycle
    
    init(service: HomeViewServiceProtocol) {
        self.service = service
        self.error = .init()
        self.isLoading = .init()
        self.mainTitle = .init(value: "")
        self.recommendCustomMenus = .init(value: [])
        self.presentedDetailCustomMenuData = .init()
    }
    
    func subscribeInputs() {
        self.service.error.subscribe(onNext: { [weak self] err in
            self?.error.onNext(err)
        })
        .disposed(by: self.disposeBag)
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    // MARK: input function
    
    func requestRecommendCustomMenus() {
        self.service.getSampleCustomMenus().subscribe(onNext: { [weak self] menus in
            self?.mainTitle.onNext(menus.title)
            self?.recommendCustomMenus.onNext(menus.recommendCustomMenus)
        })
        .disposed(by: self.disposeBag)
    }
    
    func requestDetailCustomMenuDataAtIndex(index: Int) {
        self.isLoading.onNext(true)
        self.recommendCustomMenus.subscribe(onNext: { [weak self] menus in
            let item = menus[index]
            let data = CustomMenuObjModel(id: item.id, name: item.name, description: "", imageUrl: item.imageUrl, createdDate: item.createdDate)
            self?.service.getDetailCustomMenuData(data: data).subscribe(onNext: { [weak self] detailObj in
                self?.outputs.presentedDetailCustomMenuData.onNext(HomeViewModel.RecommendDetailViewInfoModel(detailServiceInfoModel: DetailService.DetailServiceInfoModel(customMenuDetailObjModel: detailObj, customMenuObjModel: data), backgroundColor: item.backgroundColor.hexToColor()))
                self?.isLoading.onNext(false)
            })
            .disposed(by: self?.disposeBag ?? DisposeBag())
        })
        .disposed(by: self.disposeBag)
    }
    
    // MARK: output function

}
