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
}

protocol HomeViewModelOutput {
    var error: PublishSubject<String> { get }
    var isLoading: PublishSubject<Bool> { get }
    var mainTitle: BehaviorSubject<String> { get }
    var recommendCustomMenus: BehaviorSubject<[RecommendCustomMenu]> { get }
}

protocol HomeViewModelType {
    var inputs: HomeViewModelInput { get }
    var outputs: HomeViewModelOutput { get }
}

class HomeViewModel: MVVMViewModel, HomeViewModelType, HomeViewModelInput, HomeViewModelOutput {
    
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
    
    // MARK: lifeCycle
    
    init(service: HomeViewServiceProtocol) {
        self.service = service
        self.error = .init()
        self.isLoading = .init()
        self.mainTitle = .init(value: "")
        self.recommendCustomMenus = .init(value: [])
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
    
    // MARK: function
    
    func requestRecommendCustomMenus() {
        self.service.getSampleCustomMenus().subscribe(onNext: { [weak self] menus in
            print("menus: \(menus)")
            self?.mainTitle.onNext(menus.title)
            self?.recommendCustomMenus.onNext(menus.recommendCustomMenus)
        })
        .disposed(by: self.disposeBag)
    }
    

    

    

}
